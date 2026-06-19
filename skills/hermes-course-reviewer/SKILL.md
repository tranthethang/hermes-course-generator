---
name: hermes-course-reviewer
description: >-
  Review and grade course sections and lessons against strict quality criteria, run automated
  validations, export review JSONs, and merge approved sections.
---

# Skill: Hermes Course Reviewer

## Overview

This skill guides the Reviewer Agent to acts as an independent quality gate. It verifies section
files, grades them, and merges them into complete, publication-ready lessons.

## Part 1: Section Review Workflow

### Step 1: Validate Structural and Quantitative Constraints

Run a review check on the target section file under `output/sections/{level}/`:

- **Word/Character Count:** File must contain at least 500 words (~3,000 characters).
- **Line Count:** File must contain at least 120 lines.
- **Code Block Count:** File must contain at least 2 code blocks with 10+ lines of total code.
- **Emoji Cleanliness:** Verify that there are absolutely **no emojis** in the file.
- **Language Cleanliness:** Verify that there are no Chinese or other non-Vietnamese/non-English
  characters.
- **MDX Safety:** Ensure all comparison symbols and generics (e.g. `<T>`) are in inline code blocks
  or escaped.
- **No Code Execution:** Absolutely DO NOT run any code examples in the lesson using Bash/compilers.
  Review code purely via LLM analytical logic.

### Step 2: Evaluate Technical and Pedagogical Quality

Read the content and evaluate it against `quality_checklist.md`:

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

Open the merged file and replace the `{/* HERMES:FILL ... */}` placeholders with detailed content:

- **Lesson Introduction:** Clear context, prerequisite notes, and estimated completion time.
- **Learning Objectives:** Structured list of what the learner will accomplish.
- **Recap:** A 5-8 bullet-point summary of the core lesson concepts.
- **Comprehensive Exercises:** 2-3 exercises combining knowledge from all sections, each with
  requirements, sample input, and expected output.
- **Quiz:** Exactly 5 questions (2 theory, 2 code-reading, 1 debug) with 4 options each, and answers
  hidden inside `<details>` tags.

### Step 4: Final Lesson Review & Changelog Update

- Self-review the merged lesson file using Checklist 2 in `quality_checklist.md`.
- Save the review results to `output/reviews/lessons/{level}/{lesson_id}_review.json`.
- Update state:
  ```bash
  hermes-course-generator state update --key "active_lesson_id" --value "{lesson_id}"
  ```
- Append the merge details to `output/changelog.md` following the changelog format.
