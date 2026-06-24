import re

def check_mdx_safety(content):
    lines = content.splitlines()
    cleaned_lines = []
    
    in_yaml = False
    in_code_block = False
    in_mdx_comment = False
    
    for line_num, line in enumerate(lines, 1):
        stripped = line.strip()
        
        # 1. YAML frontmatter
        if line_num == 1 and stripped == "---":
            in_yaml = True
            cleaned_lines.append(" " * len(line))
            continue
        elif in_yaml:
            if stripped == "---":
                in_yaml = False
            cleaned_lines.append(" " * len(line))
            continue
            
        # 2. Fenced code block
        if stripped.startswith("```"):
            in_code_block = not in_code_block
            cleaned_lines.append(" " * len(line))
            continue
        elif in_code_block:
            cleaned_lines.append(" " * len(line))
            continue
            
        # 3. MDX comment
        if in_mdx_comment:
            if "*/}" in line:
                in_mdx_comment = False
                idx = line.find("*/}")
                line = " " * (idx+3) + line[idx+3:]
            else:
                cleaned_lines.append(" " * len(line))
                continue
        elif "{/*" in line:
            if "*/}" in line:
                pass
            else:
                in_mdx_comment = True
                idx = line.find("{/*")
                line = line[:idx] + " " * (len(line) - idx)
                
        # 4. Blank out inline code
        def blank_inline(match):
            return "`" + " " * (len(match.group(0)) - 2) + "`"
        line_clean = re.sub(r'`[^`\n]*`', blank_inline, line)
        
        # 5. Blank out single-line MDX comments
        line_clean = re.sub(r'\{\/\*.*?\*\/\}', lambda m: " " * len(m.group(0)), line_clean)
        
        cleaned_lines.append(line_clean)
        
    errors = []
    for line_num, line_clean in enumerate(cleaned_lines, 1):
        if re.match(r'^\s*>', line_clean):
            continue
            
        # Check for unescaped '<'
        for match in re.finditer(r'(?<!\\)<', line_clean):
            idx = match.start()
            suffix = line_clean[idx:]
            is_allowed = False
            for tag in ['<details>', '</details>', '<summary>', '</summary>', '<br />', '<br/>']:
                if suffix.lower().startswith(tag):
                    is_allowed = True
                    break
            if not is_allowed:
                context = line_clean[max(0, idx-10):min(len(line_clean), idx+15)].strip()
                errors.append(f"Line {line_num}: Unescaped '<' found in: '{context}'")
                
        # Check for unescaped '>'
        for match in re.finditer(r'(?<!\\)>', line_clean):
            idx = match.start()
            prefix = line_clean[:idx+1]
            is_allowed = False
            for tag in ['<details>', '</details>', '<summary>', '</summary>', '<br />', '<br/>']:
                if prefix.lower().endswith(tag):
                    is_allowed = True
                    break
            if not is_allowed:
                context = line_clean[max(0, idx-15):min(len(line_clean), idx+10)].strip()
                errors.append(f"Line {line_num}: Unescaped '>' found in: '{context}'")
                
    return errors

# Test cases
test_content = """---
title: "Box<T>: Heap Allocation"
---

# Box<T>: Heap Allocation

Inside code block it is safe:
```rust
let x: Vec<T> = vec![];
```

Inside inline code it is safe: `Box<T>`.

Outside inline code it is unsafe: Box<T> or Rc<RefCell<T>>.
And also: always >= min and <= max.

We also allow <details> and <summary>View Answer</summary></details> and <br />.
But we do not allow raw <.
"""

errors = check_mdx_safety(test_content)
for err in errors:
    print(err)
