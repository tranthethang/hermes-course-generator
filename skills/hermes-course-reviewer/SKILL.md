---
name: hermes-course-reviewer
description: >-
  Review and grade course sections and lessons against strict quality criteria, run automated
  validations, export review JSONs, and merge approved sections.
allowed-tools: [read_file, write_file, run_command]
---

# Skill: Hermes Course Reviewer

## Overview

This skill guides the Reviewer Agent to acts as an independent quality gate. It verifies section
files, grades them, and merges them into complete, publication-ready lessons.

## Part 1: Section Review Workflow

### Step 1: Validate Structural and Quantitative Constraints

First, read `state.md` and `style_guide.md` from the current working directory of the project (using
`./state.md` and `./style_guide.md` to ensure they are read from the active workspace directory, not
the skill installation directory).

Run a review check on the target section file under `output/sections/{level}/`:

- **Word/Character Count:** File must contain at least 500 words (~3,000 characters).
- **Line Count:** File must contain at least 120 lines.
- **Code Block Count:** File must contain at least 2 code blocks with 10+ lines of total code.
- **Emoji Cleanliness:** Verify that there are absolutely **no emojis** in the file.
- **Language Cleanliness:** Verify that the content is written in the target course language
  specified by `course_language` in `state.md` (read from `./state.md`). If `course_language` is
  "vi", verify that there are no non-Vietnamese/non-English characters. If `course_language` is "en"
  (or default/not specified), verify that all content is in English. No Chinese or other foreign
  characters are allowed. **CRITICAL:** The `course_language` in `state.md` is the absolute source
  of truth. Under no circumstances should you modify or update `course_language` in `state.md` based
  on past memories, other projects, or conversation context.
- **Heading Compliance:** Verify that all headings follow the exact ordering and translations
  defined in `style_guide.md` (read from `./style_guide.md`) Section 9.1 based on the target
  `course_language` (English headings for `en` or default; Vietnamese headings for `vi`). Ensure
  that no custom second-level headings (`##`) are used; all subheadings must be third-level (`###`)
  or fourth-level (`####`) under the main concepts section ("Main Concepts" or "Khái niệm cốt lõi").
- **MDX Safety:** Ensure all comparison symbols, generics (e.g. `<T>`), and literal curly braces
  (`{`, `}`) in plain text are in inline code blocks or escaped.
- **No Code Execution:** Absolutely DO NOT run any code examples in the lesson using Bash/compilers.
  Review code purely via LLM analytical logic.

### Step 2: Evaluate Technical and Pedagogical Quality

Read the content and evaluate it against `quality_checklist.md` (read from `./quality_checklist.md`
in the current working directory of the project):

- **Explanations:** Check if concepts are explained clearly BEFORE showing code.
- **Examples:** Confirm that code examples are realistic, useful, and follow best practices.
- **Common Mistakes:** Verify 2-4 mistakes with comparative good/bad code blocks.
- **Exercises:** Check if there is exactly 1 exercise with clear inputs/outputs and appropriate
  difficulty.
- **References:** Verify that at least 1 official reference is cited.

### Step 3: Grade and Generate Review JSON

Assign a score from 0.0 to 10.0 based on these checks:

- **Approved:** Set `status: approved` and `review_score >= 8.0` in the YAML frontmatter only if all
  quality and quantitative constraints pass.
- **Needs Revision:** Set `status: needs-revision` and `review_score < 8.0` if any constraints are
  violated or content is shallow.
- **Format Compliance Score Capping:** Under Dimension 5 (Format Compliance), if any mandatory
  heading (e.g. Introduction, Main Concepts, etc. for English; or Giới thiệu, Khái niệm cốt lõi,
  etc. for Vietnamese) is missing or custom level-2 (`##`) headings are used, the Format Compliance
  score must be capped at **5.0**. This will prevent the file from obtaining an overall score >= 8.0
  (APPROVED).
- Save the review results to:
  ```
  output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
  ```
  The JSON must outline `strengths`, `weaknesses`, and `required_fixes`.
- **Unlock State:** If the status is `approved`, run the CLI command to unlock the state, allowing
  the Writer to proceed to the next section:
  ```bash
  hermes-course-generator state update --key "locked_section" --value ""
  ```

---

## Part 2: Lesson Merging and Filling Workflow

### Step 1: Check Section Readiness

List all files for the target `lesson_id` in `output/sections/{level}/`. Confirm that:

- All required section IDs (S01, S02...) exist consecutively.
- All sections have `status: approved` and `review_score >= 8.0`.

### Step 2: Execute CLI Merge

Run the merge command:

```bash
hermes-course-generator merge --level {level} --lesson {lesson_id}
```

This merges the approved sections into a single file in `output/lessons/{level}/` and adds
placeholders.

### Step 3: Inject Lesson-Level Content

Open the merged file and replace the `{/* HERMES:FILL ... */}` placeholders with detailed content in
the target language specified by `course_language` in `state.md` (read from `./state.md` in the
current working directory, e.g., English for `en`, Vietnamese for `vi`), adhering to the headings in
`style_guide.md` Section 9.2 (read from `./style_guide.md` in the current working directory):

- **Lesson Introduction & Learning Objectives:** Clear context, prerequisite notes, and estimated
  completion time.
  - Learning objectives (3-5 objectives) must be wrapped in the Docusaurus admonition (e.g.,
    `:::info Learning Objectives After this lesson, you will be able to: ... :::` or
    `:::info Mục tiêu bài học Sau bài học này, bạn sẽ có thể: ... :::` for Vietnamese).
  - Prerequisites must be wrapped in admonition (e.g., `:::note Prerequisites ... :::` or
    `:::note Tiên quyết ... :::` for Vietnamese).
  - Estimated study time must be wrapped in admonition (e.g.,
    `:::info Estimated Time: 45 minutes :::` or `:::info Thời gian ước tính: 45 phút :::` for
    Vietnamese).
- **Recap:** A 5-8 bullet-point summary of the core lesson concepts. Use the target language heading
  (e.g., `## Lesson Recap` or `## Tóm tắt bài học`).
- **Comprehensive Exercises:** 2-3 exercises combining knowledge from all sections, each with
  requirements, sample input, and expected output. Use the target language heading (e.g.,
  `## Comprehensive Exercises` or `## Bài tập tổng hợp`).
- **Quiz:** Exactly 5 questions (2 theory, 2 code-reading, 1 debug) with 4 options each, and answers
  hidden inside `<details>` tags using appropriate summary (e.g., `<summary>Answer</summary>` or
  `<summary>Đáp án</summary>`). Use the target language heading (e.g., `## Quiz` or
  `## Trắc nghiệm`).

### Step 4: Final Lesson Review & Changelog Update

- Self-review the merged lesson file using Checklist 2 in `quality_checklist.md` (read from
  `./quality_checklist.md` in the current working directory). Verify that all lesson headings follow
  `style_guide.md` Section 9.2 exactly based on the target course language (read from
  `./style_guide.md` in the current working directory).
- Save the review results to `output/reviews/lessons/{level}/{lesson_id}_review.json`.
- Update state:
  ```bash
  hermes-course-generator state update --key "active_lesson_id" --value "{lesson_id}"
  ```
- Append the merge details to `output/changelog.md` following the changelog format.

---

## Automated Sequential/Batch Review & Merge Flow

When triggered with a request to review and merge all lessons for a level sequentially (e.g. in
Phase 4), follow this structured loop flow:

### 1. Scan Workspace and Identify Target Lessons

- **Scan Current Status:** Run the CLI command:
  ```bash
  hermes-course-generator status --level <level>
  ```
  to scan the workspace and identify the status of all lessons and sections. This must be the first step executed.
- **Log Session Resume:** Write an entry in `output/changelog.md` to document that the reviewer/merge session has resumed. List the current progress and count of reviewed/merged lessons. Do not use emojis. For example:
  ```markdown
  ## [YYYY-MM-DD HH:MM:SS +07:00] - Review and Merge Session Resumed
  
  ### Current Status
  - Resuming review/merge for level: begin
  - Status: X approved lessons, Y pending lessons remaining.
  ```
- **Identify Pending Lessons:** Identify which lessons are pending review and merging (e.g., those whose lesson files do not exist, or do not have status `reviewed`).
- **Skip Completed Lessons:** Skip merging/reviewing lessons that are already completed and reviewed.

### 2. Loop and Execute

For each pending lesson in order:

- **Report/Log Progress:** To ensure execution is not silent and the user can track progress in
  real-time:
  - If you have terminal/tool access, run an echo command (e.g.
    `echo "=== [Hermes Loop] Starting review and merge of [lesson_id] ==="` and
    `echo "=== [Hermes Loop] Completed... ==="`).
  - Otherwise, print a progress status message in your current message output, and/or write progress
    updates to a temporary progress file (e.g. `output/progress.log`).
- **Execute Single Lesson Review & Merge Workflow:** Perform Steps 1 to 4 of the merging workflow.
- **Automatically Proceed:** Immediately transition to the next lesson in the sequence.
  - If running in an autonomous/agentic loop mode (like Antigravity or Claude Code), do not pause or
    ask the user for confirmation; proceed directly to the next lesson in the same execution run.
  - If running in a co-working or conversational interface where you must stop after each response,
    output your progress report and ask the user to type "continue" or press Enter to trigger the
    next lesson.

### 3. Final Report

- Once all lessons for the level have been processed, present a summary table of the merged lessons,
  their paths, and statuses to the user.
