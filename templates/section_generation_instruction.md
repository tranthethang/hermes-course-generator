# Section Generation Instruction

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Detailed instructions on the process of generating **a single** section for the
> [Language Name] course.

---

## 1. Core Principles

- **Generate individually:** Hermes only creates **ONE** section per task. Never generate multiple
  sections at once.
- **Docusaurus compatible:** All Markdown content generated must be compatible with Docusaurus MDX.
- **MDX Safety (Extremely Important):** Absolutely DO NOT write raw comparison operators or generic
  type brackets directly in plain text (e.g., `<T>`, `<string>`, `<int>`). The Docusaurus MDX parser
  will misinterpret these as unclosed HTML/JSX tags and fail compilation. You must write these
  inside backticks (e.g., `` `<T>` ``) or escape the `<` and `>` characters.
- **Admonitions:** Use Docusaurus Admonitions syntax (`:::note`, `:::tip`, `:::info`, `:::warning`,
  `:::danger`) instead of GitHub-style (`> [!NOTE]`).

---

## 2. Inputs to Read Before Starting

Hermes MUST read the following files from the active workspace. Since the workspace root may be the
course directory, these configuration files might be located directly in the current directory `./`
or inside the `./output/` subdirectory. Search both locations (preferring `./` if present, then
falling back to `./output/`):

```
1. goal.md                  → (read from `./goal.md` or `./output/goal.md`) Understand execution goals, autonomous rules, and error policies
2. overview.md              → (read from `./overview.md` or `./output/overview.md`) Understand the overall course goals and audience
3. architecture.md          → (read from `./architecture.md` or `./output/architecture.md`) Understand where the current lesson fits in the course
4. template_section.md      → (read from `./template_section.md` or `./output/template_section.md`) Check the mandatory section structure
5. style_guide.md           → (read from `./style_guide.md` or `./output/style_guide.md`) Apply writing style rules
6. knowledge_sources.md     → (read from `./knowledge_sources.md` or `./output/knowledge_sources.md`) Identify permitted reference sources
7. quality_checklist.md     → (read from `./quality_checklist.md` or `./output/quality_checklist.md`) Understand criteria before saving
```

---

## 3. Mandatory Metadata Before Creating Section

Before writing any content, Hermes must define:

```yaml
id: l01_s01_slug # Format: l<lesson_id_lower>_s<section_id_lower>_<slug>
title: "Section title"
sidebar_label: "Section title"
sidebar_position: 1 # Display position in lesson
level: begin | advance | master
lesson_id: "L01" # E.g., L01, L02, L03
lesson_title: "Lesson title" # E.g., "Variables and Basic Data Types"
section_id: "S01" # E.g., S01, S02, S03
section_title: "Section title" # E.g., "Introduction to variables in [Language Name]"
language_version: "1.0.0" # Language version being taught
review_score: 0.0
status: draft
```

If any of these fields are missing – **STOP** and ask the user to provide them before proceeding.

---

## 4. Section Generation Process (7 Steps)

### Step 1: Understand Lesson Context

Provide clear answers to these questions:

- What does this lesson teach?
- Where is this section located in the lesson?
- What did the previous section (if any) teach?
- What will the next section (if any) teach?
- What does the learner need to know before reading this section?

### Step 2: Determine Learner Level

Apply criteria appropriate for the level:

| Level     | Requirements                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------------ |
| `begin`   | Do not assume prior knowledge. Explain all concepts from scratch. Use simple, relatable examples.      |
| `advance` | Assume knowledge of basic [Language Name]. Focus on best practices, patterns, and edge cases.          |
| `master`  | Assume hands-on professional experience. Deep dive into internals, performance, and advanced patterns. |

### Step 3: Research the Topic

Look up information from permitted sources (see `knowledge_sources.md`):

- Official documentation of [Language Name] (e.g., Python Docs, Rust Docs, MSDN for C#...)
- Technical guidelines, naming standards, or language specifications (e.g., PEPs, RFCs, Language
  specifications)
- Changelogs of [Language Name] to ensure modern and updated features

Cite your references in the `## References` section of the document.

### Step 4: Create Section Content

The section must follow the exact structure from `template_section.md`.

Mandatory content requirements:

#### 4.1 Explanation

- Explain concepts using clear, natural language.
- Use relatable real-world analogies.
- Explain WHY this concept is important.
- Length of the explanation text (under Main Concepts): 150-400 words depending on topic complexity.
  Note: total section length (all headings combined) should be 500-1500 words.

#### 4.2 Code Examples

- Quantity: Minimum of 2, maximum of 5 examples.
- Each example must have explanatory comments.
- Code must be syntactically correct and free of compilation/syntax errors. For SQL/MongoDB, ensure
  syntax accuracy against standard documentation; establishing a running database is not required.
- First example: the simplest.
- Last example: realistic and more complex.

```[language]
# [Language Name] [Language Version]
# Uses modern and standardized syntax of the language
# [Code demonstrating functions/variables...]
```

#### 4.3 Common Mistakes

- List 2-4 common mistakes.
- Each mistake needs: description + bad code + good code + explanation.
- Use the following pattern for each mistake:

```[language]
// INCORRECT
// [bad code demonstrating the mistake]
// Error: [what error this produces]

// CORRECT
// [corrected code]
```

#### 4.4 Best Practices

- List 2-3 best practices related to the topic.
- Reference official style guides or specifications (e.g., language-specific style guides, RFCs)
  where applicable.

#### 4.5 Mini Exercise

- Exactly 1 small exercise.
- Must include: requirements + sample input + expected output.
- DO NOT provide the solution directly in the section (Hermes will create it separately).

#### 4.6 Summary

- 3–5 bullet points summarizing the main takeaways.

---

### Step 5: Self-Review Section

After writing the content, Hermes performs a self-review according to the following template:

```json
{
  "self_review": {
    "technical_accuracy": {
      "score": 0,
      "note": "Is the code syntax correct? Do the APIs exist?"
    },
    "teaching_quality": {
      "score": 0,
      "note": "Are explanations clear? Is it level-appropriate?"
    },
    "example_quality": {
      "score": 0,
      "note": "Are examples realistic? Is there a sufficient number of them?"
    },
    "exercise_quality": {
      "score": 0,
      "note": "Is the exercise difficulty appropriate?"
    },
    "format_compliance": {
      "score": 0,
      "note": "Does it follow template_section.md exactly?"
    },
    "total_score": 0,
    "pass": false,
    "weaknesses": [],
    "required_fixes": []
  }
}
```

Calculate the `total_score` = weighted average of the 5 criteria.

### Step 6: Handle Review Results

```
If total_score >= 8.0:
  → Proceed to Step 7 (Save file)

If total_score >= 6.0 and < 8.0:
  → Apply required_fixes
  → Improve the weakest dimensions
  → Re-review (back to Step 5)
  → Max 2 fixes; if still < 8.0, report the issue

If total_score < 6.0:
  → Discard all written content
  → Rewrite from scratch using a different approach (Step 4)
  → Max 1 rewrite
```

### Step 7: Save Section

Save to the correct path according to `file_naming_convention.md`:

```
output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
```

Examples:

```
output/sections/begin/L01_S01_variable-and-assignment.mdx
output/sections/advance/L03_S02_decorator-pattern.mdx
output/sections/master/L05_S01_metaclass-internals.mdx
```

After successfully saving, the Agent CALLS THE CLI COMMAND TO UPDATE STATE:

```bash
hermes-course-generator state update --key "active_section_id" --value "{lesson_id}_{section_id}"
```

---

## 5. Mandatory Section Structure

See `template_section.md` for the detailed structure.

Mandatory headings in order:

```markdown
---
id: ...
title: ...
sidebar_label: ...
sidebar_position: ...
level: ...
lesson_id: ...
lesson_title: ...
section_id: ...
section_title: ...
language_version: ...
review_score: 0.0
status: draft | reviewed | approved
---

# {Section Name}

## Introduction

## Main Concepts

## Code Examples

## Common Mistakes

## Best Practices

## Mini Exercise

## Summary

## References
```

---

## 6. Rules for Using `template_section.md`

- Read the entire `template_section.md` before writing.
- Keep heading order.
- Keep YAML frontmatter fields.
- Populate `review_score` correctly after self-review.
- Set `status: approved` only when score ≥ 8.0.

---

## 7. Expected Output

When completed, Hermes reports:

```
Section created: output/sections/begin/L01_S01_variable-and-assignment.mdx
Self-review score: 8.5/10
Weaknesses: [...]
Applied fixes: [...]
Status: approved
```
