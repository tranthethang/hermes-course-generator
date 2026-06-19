# Review Instruction

> **Target Audience:** Hermes AI Agent (acting as Reviewer)  
> **Purpose:** Strict review criteria for sections and lessons.

---

## 1. Review Principles

> When reviewing, Hermes acts as an **independent reviewer**, not the author of the content.
>
> Mission: **Find weaknesses** – not praise the content.

Mandatory rules:

- Must list at least 1 weakness even if the content is good.
- Must list specific, non-generic `required_fixes`.
- The score must reflect reality, do not round up.

---

## 2. Section Review Criteria (5 Dimensions)

### Dimension 1: Technical Accuracy — Weight 30%

| Score | Criteria                                                                                     |
| ----- | -------------------------------------------------------------------------------------------- |
| 9–10  | All code runs, APIs are correct, [Language Version] is specified, no hallucinated functions. |
| 7–8   | Code runs, 1–2 minor issues with style or not optimal.                                       |
| 5–6   | Code has minor runtime errors or uses deprecated APIs.                                       |
| 3–4   | Code has logic errors, APIs do not exist, or missing exception handling.                     |
| 0–2   | Code is completely incorrect, hallucinated APIs, or cannot run.                              |

Questions to check:

- Does the code run with [Language Version]?
- Are non-existent APIs/modules used?
- Are type hints correct?
- Is exception handling appropriate?
- Are there notes when verification is required?

### Dimension 2: Teaching Quality — Weight 25%

| Score | Criteria                                                                      |
| ----- | ----------------------------------------------------------------------------- |
| 9–10  | Clear, logical explanation, level-appropriate, good analogies used.           |
| 7–8   | Explanations are clear enough but lack some analogies or fail to explain why. |
| 5–6   | Explanation is okay but hard to follow or not level-appropriate.              |
| 3–4   | Explanation is unclear, too short, or assumes incorrect prior knowledge.      |
| 0–2   | No explanation, only code without guidance.                                   |

Questions to check:

- Is there an explanation before showing code?
- Are there relatable, real-life analogies?
- Can a learner at level `{level}` understand it?
- Does it explain WHY, not just HOW?

### Dimension 3: Example Quality — Weight 20%

| Score | Criteria                                                               |
| ----- | ---------------------------------------------------------------------- |
| 9–10  | ≥2 examples, practical, commented, gradually increasing in complexity. |
| 7–8   | 2 examples are good but 1 is too simple or lacks comments.             |
| 5–6   | Only 1 example or examples are impractical (only Hello World).         |
| 3–4   | Examples fail to illustrate the concept being taught.                  |
| 0–2   | No examples or incorrect examples.                                     |

### Dimension 4: Exercise Quality — Weight 15%

| Score | Criteria                                                                                        |
| ----- | ----------------------------------------------------------------------------------------------- |
| 9–10  | Clear exercise, has sample input/output, level-appropriate, tests the correct knowledge taught. |
| 7–8   | Exercise is okay but lacks sample input/output or is slightly hard/easy.                        |
| 5–6   | Exercise is ambiguous or not directly related to content.                                       |
| 3–4   | Exercise is too simple (only requires changing one value) or insolvable.                        |
| 0–2   | No exercise.                                                                                    |

### Dimension 5: Format Compliance — Weight 10%

| Score | Criteria                                                                     |
| ----- | ---------------------------------------------------------------------------- |
| 9–10  | Complete YAML frontmatter, correct heading order, clean Markdown formatting. |
| 7–8   | Correct structure but missing 1–2 fields in frontmatter.                     |
| 5–6   | Missing some required headings.                                              |
| 3–4   | Significant structural deviations from template.                             |
| 0–2   | Does not follow template.                                                    |

---

## 3. Score Calculation Formula

```
total_score = (
  technical_accuracy * 0.30 +
  teaching_quality * 0.25 +
  example_quality * 0.20 +
  exercise_quality * 0.15 +
  format_compliance * 0.10
)
```

Round to 1 decimal place.

---

## 4. Pass / Fail Conditions

| Result       | Condition                  | Action                                  |
| ------------ | -------------------------- | --------------------------------------- |
| **APPROVED** | `total_score >= 8.0`       | Save file with `status: approved`       |
| **REVISE**   | `6.0 <= total_score < 8.0` | Apply `required_fixes`, re-review       |
| **REWRITE**  | `total_score < 6.0`        | Rewrite the entire section from scratch |

---

## 5. Output Review — JSON Format

Hermes MUST export review results in the following JSON format:

```json
{
  "review_type": "section",
  "target_file": "output/sections/begin/L01_S01_variable-and-assignment.mdx",
  "review_timestamp": "2026-06-18T10:00:00+07:00",
  "scores": {
    "technical_accuracy": {
      "score": 8.5,
      "notes": "Code runs, type hints are correct. Missing ValueError handling in example 2."
    },
    "teaching_quality": {
      "score": 9.0,
      "notes": "Explanation is clear, good analogy. Correctly fits beginner level."
    },
    "example_quality": {
      "score": 8.0,
      "notes": "3 good examples. Example 2 lacks comments explaining complex lines."
    },
    "exercise_quality": {
      "score": 7.5,
      "notes": "Exercise is clear but lacks sample output."
    },
    "format_compliance": {
      "score": 10.0,
      "notes": "Complete YAML, correct heading order, clean Markdown."
    }
  },
  "total_score": 8.6,
  "result": "APPROVED",
  "strengths": [
    "Explains the variable concept very clearly for beginners.",
    "relatable 'storage box' analogy.",
    "Lists 3 practical common mistakes."
  ],
  "weaknesses": [
    "Example 2 lacks comments explaining the complex list comprehension.",
    "The mini exercise is missing a sample output."
  ],
  "required_fixes": [
    {
      "priority": "medium",
      "location": "## Code Examples > Example 2",
      "issue": "Missing comments for the list comprehension line.",
      "fix": "Add comment '# Create list of even numbers from 0 to 20' before that line."
    },
    {
      "priority": "low",
      "location": "## Mini Exercise",
      "issue": "Missing sample output.",
      "fix": "Add 'Expected Output: [2, 4, 6, 8, 10]'"
    }
  ]
}
```

---

## 6. Output Review — Markdown Format (Alternative)

If needed to present to human readers (not machines), use this Markdown format:

```markdown
## Review Results

**File:** `output/sections/begin/L01_S01_variable-and-assignment.mdx`  
**Time:** 2026-06-18 10:00 +07:00  
**Type:** Section Review

### Scores

| Criteria           | Score        |
| ------------------ | ------------ |
| Technical Accuracy | 8.5          |
| Teaching Quality   | 9.0          |
| Example Quality    | 8.0          |
| Exercise Quality   | 7.5          |
| Format Compliance  | 10.0         |
| **TOTAL WEIGHTED** | **8.6 / 10** |

### Result: APPROVED

### Strengths

- ...

### Weaknesses

- ...

### Required Fixes

1. [MEDIUM] ...
2. [LOW] ...
```

---

## 7. Review Lesson (After Merging)

When reviewing a merged lesson, use these additional criteria:

| Additional Criteria | Description                                                       |
| ------------------- | ----------------------------------------------------------------- |
| **Flow**            | Do the sections connect logically and smoothly?                   |
| **Completeness**    | Does the lesson include Introduction, Recap, Exercises, and Quiz? |
| **Consistency**     | Is terminology consistent throughout the lesson?                  |
| **Duplication**     | Is there any unnecessary duplicate content?                       |

Save the merged lesson review result to:

```
output/reviews/lessons/{level}/{lesson_id}_review.json
```

---

## 8. Review File Saving Rules

All review results must be saved to files for tracking and history:

```
output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
output/reviews/lessons/{level}/{lesson_id}_review.json
```

Examples:

```
output/reviews/sections/begin/L01_S01_review.json
output/reviews/lessons/advance/L02_review.json
```
