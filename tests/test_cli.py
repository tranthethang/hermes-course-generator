import sys
import os
import shutil
import tempfile
import json
import pytest
import importlib.util

# Load hermes-course-generator module dynamically
from importlib.machinery import SourceFileLoader
cli_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "../bin/hermes-course-generator"))
loader = SourceFileLoader("hermes_cli", cli_path)
spec = importlib.util.spec_from_file_location("hermes_cli", cli_path, loader=loader)
hermes = importlib.util.module_from_spec(spec)
sys.modules["hermes_cli"] = hermes
spec.loader.exec_module(hermes)

def test_slugify_plain():
    assert hermes.slugify("Hello World") == "hello-world"
    assert hermes.slugify("This is - a test!") == "this-is-a-test"

def test_slugify_vietnamese():
    assert hermes.slugify("Học máy tính và lập trình C++") == "hoc-may-tinh-va-lap-trinh-c"

def test_parse_frontmatter_basic():
    content = """---
id: L01_S01
title: "Introduction"
sidebar_position: 1
---
# Welcome
This is content."""
    meta, body = hermes.parse_frontmatter(content)
    assert meta["id"] == "L01_S01"
    assert meta["title"] == "Introduction"
    assert int(meta["sidebar_position"]) == 1
    assert "Welcome" in body

def test_parse_frontmatter_colon_in_title():
    content = """---
id: L01_S02
title: "C++ Basics: Variables"
sidebar_position: 2
---
Variables are fun."""
    meta, body = hermes.parse_frontmatter(content)
    assert meta["id"] == "L01_S02"
    assert meta["title"] == "C++ Basics: Variables"
    assert "Variables are fun." in body

def test_parse_frontmatter_list():
    content = """---
id: L01_S03
sections:
  - L01_S01
  - L01_S02
---
Body."""
    meta, body = hermes.parse_frontmatter(content)
    assert meta["id"] == "L01_S03"
    assert isinstance(meta["sections"], list)
    assert "L01_S01" in meta["sections"]
    assert "L01_S02" in meta["sections"]

def test_check_mdx_safety_clean():
    content = """# Title
This is regular text.
`code block` or <details>details text</details> is escaped or wrapped.
The operator `<` and `>` are inside code blocks.
"""
    errors = hermes.check_mdx_safety(content)
    assert len(errors) == 0

def test_check_mdx_safety_angle_brackets():
    content = """# Title
Let's check if vector<int> causes error.
"""
    errors = hermes.check_mdx_safety(content)
    assert len(errors) > 0
    assert any("Unescaped '<'" in err for err in errors)

def test_check_mdx_safety_curly_braces():
    content = """# Title
This is a bad variable: {bad_var}
"""
    errors = hermes.check_mdx_safety(content)
    assert len(errors) > 0
    assert any("Unescaped '{'" in err for err in errors)

def test_state_json_crud():
    with tempfile.TemporaryDirectory() as tmpdir:
        # Initialize workspace
        # We need templates dir configured
        # Let's mock TEMPLATE_DIR to be our actual templates folder in workspace
        old_template_dir = hermes.TEMPLATE_DIR
        hermes.TEMPLATE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../templates"))
        
        try:
            hermes.init_workspace(tmpdir)
            
            # Check state.json exists
            state_path = os.path.join(tmpdir, "state.json")
            assert os.path.exists(state_path)
            
            # Read state
            lang = hermes.read_state(tmpdir, "course_language")
            assert lang == "en"
            
            # Update state
            hermes.update_state(tmpdir, "course_name", "Test Course")
            assert hermes.read_state(tmpdir, "course_name") == "Test Course"
            
            # Validate schema constraint
            with pytest.raises(ValueError):
                # active_level must be a string, passing a list/int should fail validation
                hermes.update_state(tmpdir, "active_level", 123)
                
            # Locked section manipulation
            hermes.update_state(tmpdir, "locked_section", "L01_S01")
            assert hermes.read_state(tmpdir, "locked_section") == "L01_S01"
            
            hermes.clear_locked_section(tmpdir)
            assert hermes.read_state(tmpdir, "locked_section") == ""
        finally:
            hermes.TEMPLATE_DIR = old_template_dir

def test_state_backward_compatibility():
    with tempfile.TemporaryDirectory() as tmpdir:
        # Create an old state.md file
        state_content = """# Workspace State
workspace_version: "1.0"
technology: "Python"
technology_version: "3.11"
course_name: "Legacy Course"
course_language: "vi"
created_at: "2026-01-01 10:00:00"
last_updated_at: "2026-01-01 10:00:00"
active_level: "begin"
active_lesson_id: "L01"
active_section_id: "S01"
locked_section: "L01_S01"
"""
        with open(os.path.join(tmpdir, "state.md"), "w", encoding="utf-8") as f:
            f.write(state_content)
            
        # Trigger read_state, which should migrate
        val = hermes.read_state(tmpdir, "course_name")
        assert val == "Legacy Course"
        assert hermes.read_state(tmpdir, "technology") == "Python"
        assert hermes.read_state(tmpdir, "locked_section") == "L01_S01"
        
        # Verify state.json was created and state.md was backed up
        assert os.path.exists(os.path.join(tmpdir, "state.json"))
        assert os.path.exists(os.path.join(tmpdir, "state.md.bak"))
        assert not os.path.exists(os.path.join(tmpdir, "state.md"))
