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
5. **Course Language:** Content must be written in the language specified by `course_language` in
   `state.md` (e.g., "en" or "vi"). If `course_language` is "vi", all text must be in Vietnamese,
   except for standard technical English terms. If `course_language` is "en" (or default/not
   specified), all text must be in English. No foreign/untranslated symbols (e.g. Chinese
   characters) are allowed. **CRITICAL:** Do NOT modify `course_language` in `state.md` based on
   past memories or chat context; `state.md` is the absolute source of truth.
6. **No Code Execution:** Absolutely DO NOT run code examples in the lesson using Bash commands or
   interpreters. Only review code via your internal logic and reasoning.

## Generation Workflow

### Step 1: Read Context and Plan

Before starting, read the following workspace files. Since the active workspace root may be the
course directory, these configuration files might be located directly in the current directory `./`
or inside the `./output/` subdirectory. Search both locations (preferring `./` if present, then
falling back to `./output/`):

1. `state.md` (read from `./state.md` or `./output/state.md`) to check the current state and
   determine the `course_language` (e.g., "en" or "vi"). **CRITICAL:** Under no circumstances should
   you modify or update the `course_language` in `state.md` to align with past memories, other
   courses, or the language you are conversing in. The language specified in `state.md` is the
   absolute source of truth. **CRITICAL:** If `locked_section` is NOT empty (e.g.,
   `locked_section: "L01_S01"`), you MUST abort generation and inform the user that the workspace is
   locked until the Reviewer approves the pending section. **EXCEPTION:** If you are running in
   automated sequential/batch generation mode, you must bypass this check and continue generating
   the remaining sections in the level/batch.
2. `overview.md` (read from `./overview.md` or `./output/overview.md`) to align on objectives.
3. `architecture.md` (read from `./architecture.md` or `./output/architecture.md`) to find the exact
   lesson and section title.
4. `style_guide.md` (read from `./style_guide.md` or `./output/style_guide.md`) to follow writing
   and coding styles.
5. `template_section.md` (read from `./template_section.md` or `./output/template_section.md`) to
   understand the mandatory layout structure.

### Step 2: Research the Topic

Look up official documentation for the target programming language version to gather accurate
information, design patterns, and edge cases.

### Step 3: Write Section Content

Draft the section file following the template structure. Ensure all mandated headings are included
in order, based on the target `course_language` in `state.md` (following `style_guide.md` Section
9.1):

- **For English courses (`en` or default):**
  1. `# {Section Title}`
  2. `## Introduction` (with real-world analogies)
  3. `## Main Concepts` (pedagogical explanation of concepts before code)
  4. `## Code Examples` (simple to complex, with line-by-line comments)
  5. `## Common Mistakes` (2-4 mistakes with bad/good code comparisons)
  6. `## Best Practices` (2-3 clean code patterns)
  7. `## Mini Exercise` (requirements + sample input + expected output)
  8. `## Summary` (3-5 core takeaways)
  9. `## References` (links to official documents)

- **For Vietnamese courses (`vi`):**
  1. `# {Section Title}`
  2. `## Giới thiệu` (with real-world analogies)
  3. `## Khái niệm cốt lõi` (pedagogical explanation of concepts before code)
  4. `## Ví dụ minh họa` (simple to complex, with line-by-line comments)
  5. `## Lỗi thường gặp` (2-4 mistakes with bad/good code comparisons)
  6. `## Thực hành tốt nhất` (2-3 clean code patterns)
  7. `## Bài tập nhỏ` (requirements + sample input + expected output)
  8. `## Tóm tắt` (3-5 core takeaways)
  9. `## Tài liệu tham khảo` (links to official documents)

**CRITICAL:** Custom second-level headings (using `##`) are strictly prohibited in the section file.
Any additional subtopics or custom headers must use third-level (`###`) or fourth-level (`####`)
headings under the main concepts section ("Main Concepts" or "Khái niệm cốt lõi").

### Step 4: Verify MDX Safety

Ensure that any comparison operators (`<`, `>`), generic type parameters (e.g. `<T>`, `<string>`),
or literal curly braces (`{`, `}`) in plain text are:

- Wrapped inside inline code blocks (e.g. `` `<T>` `` or `` `{tên}` ``)
- Or properly escaped (e.g. `\<T\>` or `\{tên\}`) This prevents Docusaurus compilation failures.

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

**CRITICAL:** When running in automated sequential/batch generation mode, do NOT pause or ask the
user for confirmation/instructions after saving a section. You must automatically proceed to the
next section in the sequence. Only report completion and prompt the user to trigger the Reviewer
Agent after ALL sections in the level/batch have been generated.

---

## Automated Sequential/Batch Generation Flow

When triggered with a request to write all sections for a level sequentially (e.g. in Phase 2),
follow this structured loop flow:

### 1. Scan Workspace and Identify Pending Sections

- **Scan Current Status:** Run the CLI command:
  ```bash
  hermes-course-generator status --level <level>
  ```
  to scan the workspace and identify the status of all sections. This is the absolute first step and must be executed before writing any new sections.
- **Log Session Resume:** Write an entry in `output/changelog.md` to document that the session has resumed. List the current count of approved and pending sections. Do not use emojis. For example:
  ```markdown
  ## [YYYY-MM-DD HH:MM:SS +07:00] - Session Resumed
  
  ### Current Status
  - Resuming generation for level: begin
  - Status: X approved sections, Y pending sections remaining.
  ```
- **Filter Pending Sections:** Identify the sections that are pending (i.e., those whose files do not exist, or have a status other than `approved`).
- **Skip Approved Sections:** Absolutely skip generating any section file that is already marked as `approved` and has a score >= 8.0, unless explicitly requested to overwrite them.

### 2. Loop and Execute

For each pending section in order:

- **Report/Log Progress:** To ensure execution is not silent and the user can track progress in
  real-time:
  - If you have terminal/tool access, run an echo command (e.g.
    `echo "=== [Hermes Loop] Starting [lesson_id]_[section_id] ==="` and
    `echo "=== [Hermes Loop] Completed... ==="`).
  - Otherwise, print a progress status message in your current message output, and/or write progress
    updates to a temporary progress file (e.g. `output/progress.log`).
- **Execute Single Section Workflow:** Perform Steps 1 to 6 of this skill for the section.
  - **Exception:** Do not set a non-empty `locked_section` state in `state.md` during Step 6 until
    the very last section of the level has been successfully saved. Keep `locked_section: ""` during
    intermediate sections to avoid locking yourself.
- **Update Changelog:** Append the section creation/modification details to `output/changelog.md`
  following the changelog format.
- **Automatically Proceed:** Immediately transition to the next section in the sequence.
  - If running in an autonomous/agentic loop mode (like Antigravity or Claude Code), do not pause or
    ask the user for confirmation; proceed directly to the next section in the same execution run.
  - If running in a co-working or conversational interface where you must stop after each response,
    output your progress report and ask the user to type "continue" or press Enter to trigger the
    next section.

### 3. Final Report

- Once all sections for the level have been processed, present a summary table of the generated
  sections, their paths, and scores to the user, and prompt them to trigger the Validator/Reviewer
  phase.
