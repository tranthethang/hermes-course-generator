---
name: hermes-course-writer
description: >-
  Research and write high-quality, comprehensive course sections one at a time, complying with MDX
  safety standards, length constraints, and coding styles.
---

# Skill: Hermes Course Writer

## Overview

This skill guides the Writer Agent to research and write a single, comprehensive course section. The
writer must ensure technical accuracy, clear pedagogy, and Docusaurus compatibility.

## Content Constraints

To prevent shallow placeholder text, every generated section must strictly meet the following
constraints:

1. **Length:** Minimum **500 words** (approximately **3,000 characters** including spaces).
2. **Line Count:** Minimum **120 lines** for the `.mdx` file.
3. **Runnable Code Blocks:** Minimum **2 code blocks** containing at least **10 lines of code**
   combined.
4. **Emoji Prohibition:** Absolutely **NO emojis** anywhere in headings, lists, inline text, or
   comments.
5. **Vietnamese Language:** All text must be in Vietnamese, except for standard technical English
   terms. No foreign/untranslated symbols (e.g. Chinese characters) are allowed.
6. **No Code Execution:** Absolutely DO NOT run code examples in the lesson using Bash commands or
   interpreters. Only review code via your internal logic and reasoning.

## Generation Workflow

### Step 1: Read Context and Plan

Before starting, read the following workspace files:

1. `state.md` to check the current state. **CRITICAL:** If `locked_section` is NOT empty (e.g.,
   `locked_section: "L01_S01"`), you MUST abort generation and inform the user that the workspace is
   locked until the Reviewer approves the pending section.
2. `overview.md` to align on objectives.
3. `architecture.md` to find the exact lesson and section title.
4. `style_guide.md` to follow writing and coding styles.
5. `template_section.md` to understand the mandatory layout structure.

### Step 2: Research the Topic

Look up official documentation for the target programming language version to gather accurate
information, design patterns, and edge cases.

### Step 3: Write Section Content

Draft the section file following the template structure. Ensure all mandated headings are included
in order:

1. `# {Section Title}`
2. `## Introduction` (with real-world analogies)
3. `## Main Concepts` (pedagogical explanation of concepts before code)
4. `## Code Examples` (simple to complex, with line-by-line comments)
5. `## Common Mistakes` (2-4 mistakes with bad/good code comparisons)
6. `## Best Practices` (2-3 clean code patterns)
7. `## Mini Exercise` (requirements + sample input + expected output)
8. `## Summary` (3-5 core takeaways)
9. `## References` (links to official documents)

### Step 4: Verify MDX Safety

Ensure that any comparison operators (`<`, `>`) or generic type parameters (e.g. `<T>`, `<string>`)
are:

- Wrapped inside inline code blocks (e.g. `` `<T>` ``)
- Or properly escaped (e.g. `\<T\>`) This prevents Docusaurus compilation failures.

### Step 5: Verify Code Correctness

- Extract all code blocks from your draft.
- Ensure the code conforms to the target language version.
- Validate that variables are named in descriptive English and that comments explain **why** rather
  than **what**.
- **Security Rule:** Do NOT run a local compilation or execution. Verify code correctness purely
  through careful reading and logical analysis.

### Step 6: Save the Draft Section

Save the section using the naming convention:

```
output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
```

Once saved, run the state update commands to update the active section and lock the workspace:

```bash
hermes-course-generator state update --key "active_section_id" --value "{lesson_id}_{section_id}"
hermes-course-generator state update --key "locked_section" --value "{lesson_id}_{section_id}"
```

Report completion of the draft to the user and ask them to trigger the Reviewer Agent.
