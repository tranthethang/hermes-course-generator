---
name: hermes-course-evaluator
description: >-
  Independent quality evaluator for course sections. Reads section files from disk,
  applies the 5-dimension scoring rubric, and outputs structured JSON review results.
  Does NOT write course content. Does NOT merge lessons. Only grades.
allowed-tools: [read_file, run_command]
---

# Skill: Hermes Course Evaluator

## Overview

This skill guides the Evaluator Agent to perform independent, unbiased quality grading on course sections. The Evaluator Agent operates independently of the Writer Agent and does not participate in writing or modifying section content. Its sole responsibility is to evaluate generated section files against a strict scoring rubric, record detailed reviews, and update their compliance status.

## Tasks and Execution

### Task 1: Unbiased Evaluation

As an independent evaluator, you must load the target file from the workspace, evaluate it objectively, and verify that it adheres to all defined guidelines.

#### Scoring Rubric (5 Dimensions):

1. **Completeness and Depth (Weight: 25%):**
   - Check if all required sections are present and fully fleshed out.
   - Verify that there are no empty placeholders, incomplete explanations, or TODO marks.
   - Confirm that the content is detailed enough to teach the concept thoroughly.

2. **Technical Accuracy and Executability (Weight: 25%):**
   - Verify that all code examples are correct, compile/run without errors, and follow best practices.
   - Validate that commands and instructions are accurate and match the target technology.

3. **Structural and Formatting Compliance (Weight: 20%):**
   - Ensure there is exactly one Level-1 heading `# {Section Name}` matching `section_title`.
   - Confirm that no custom Level-2 headings exist and that standard Level-2 headings are in the correct order.
   - Verify the presence and correctness of all required frontmatter metadata fields.

4. **MDX Safety and Robustness (Weight: 20%):**
   - Validate that the file compiles successfully and has no unescaped syntax characters.
   - Ensure all comparison operators (`<`, `>`), generics, and literal curly braces (`{`, `}`) in plain text are properly escaped or wrapped in backticks.

5. **Language and Style (Weight: 10%):**
   - Check that the text is written in a professional, clear, and concise tone.
   - Verify that no emojis are present anywhere in the file.
   - Ensure formatting is clean and readable.

### Task 2: Automated Validation & CLI Execution

To assist in validation, use the CLI's `evaluate` subcommand:

```bash
hermes-course-generator evaluate --level <level> --file <filename> --path <workspace_path>
```

- `<level>`: The course level ("begin", "advance", or "master").
- `<filename>`: The name of the MDX file (e.g. `L01_S01_variables.mdx`).
- `<workspace_path>`: Path to the course workspace (default is current directory).

This command parses the file, executes MDX safety checks, and performs structural validations. The CLI outputs a structured JSON report. You must integrate these results into your overall evaluation.

### Task 3: Output Review and State Update

After scoring the section:
1. Write a structured JSON review report to `output/reviews/sections/{level}/{filename}.json`.
2. The review report must follow this format:
   ```json
   {
     "file": "L01_S01_variables.mdx",
     "level": "begin",
     "scores": {
       "completeness": 8.5,
       "accuracy": 9.0,
       "structure": 8.0,
       "safety": 9.0,
       "style": 8.5
     },
     "overall_score": 8.6,
     "status": "approved",
     "detailed_feedback": "Explain strengths and areas for improvement here. Keep tone professional and text-only."
   }
   ```
3. Update the section file's metadata:
   - `review_score`: Set to the calculated overall score.
   - `status`: Set to `approved` (if score >= 8.0) or `needs-revision` (if score < 8.0).
4. If approved, use the CLI `state clear-lock` (or `clear-lock`) command to release the locked section, allowing the next section to be generated:
   ```bash
   hermes-course-generator state clear-lock --path <workspace_path>
   ```
