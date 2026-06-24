---
name: hermes-course-validator
description: >-
  Verify all course section files for format, metadata, and headings structure, and reorder
  Docusaurus sidebar positions.
---

# Skill: Hermes Course Validator

## Overview

This skill guides the Validator Agent to perform structural checks on course sections, identify
files that violate guidelines (missing metadata or incorrect headings), and apply metadata
corrections including Docusaurus sidebar position reordering.

## Tasks and Execution

### Task 1: Verify Course Sections

To run verification on all course sections in a workspace level, use the CLI:

```bash
hermes-course-generator verify --path <workspace_path> --level <level>
```

- `<workspace_path>`: The absolute path to the course workspace (containing the output directory).
- `<level>`: Set to "begin", "advance", "master", or "all" to check specific or all levels.

#### Verification Criteria:

1. **Frontmatter presence:** Ensure all section files have a valid YAML frontmatter block starting
   and ending with `---`.
2. **Metadata Key/Value validation:**
   - Must contain: `id`, `title`, `sidebar_label`, `sidebar_position` (int), `level`, `lesson_id`
     (format Lxx), `lesson_title`, `section_id` (format Sxx), `section_title`, `language_version`,
     `review_score` (float), `status`.
3. **Headings validation:**
   - There must be exactly one Level-1 heading `# {Section Name}` matching `section_title`.
   - No custom Level-2 headings (`##`) are allowed.
   - All standard Level-2 headings must exist and be in the correct order depending on language
     (English vs Vietnamese).
4. **MDX Safety:** Ensure all comparison symbols, generics (e.g. `<T>`), and literal curly braces
   (`{`, `}`) in plain text are wrapped in inline code blocks or escaped.

### Task 2: Fix and Reorder Sidebar Positions

If files lack metadata or have inconsistent sidebar positions, use the CLI to automatically fix and
reorder them:

```bash
hermes-course-generator reorder --path <workspace_path> --level <level> --mode <mode>
```

- `--mode`: Can be `flat` (sets sequential sidebar_position across the entire level `1..N`) or
  `nested` (sets sequential sidebar_position within each lesson `1..6`). Use `flat` if you copy all
  section files into a single flat Docusaurus folder.
- If a section file is missing frontmatter entirely, the command automatically parses
  `architecture.md` and the file's first Level-1 heading to reconstruct the missing frontmatter and
  insert it at the top of the file.
