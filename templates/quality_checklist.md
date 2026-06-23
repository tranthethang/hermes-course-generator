# Quality Checklist

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Mandatory checklist before saving a section or merging a lesson.

---

## Usage Guide

- Run the checklist **before saving** any file.
- Mark `[x]` for each checked item.
- If any `[REQUIRED]` item is not met → **DO NOT save the file**.
- If an `[OPTIONAL]` item is not met, note it down but saving the file is still allowed.

---

## Checklist 1: Before Saving a Section

### A. Language Technology [REQUIRED]

````
[ ] Code in the section has been checked for syntax (no SyntaxError). For SQL/MongoDB, check for syntax validity against standard specifications.
[ ] All functions/classes/modules/keywords mentioned exist in the specified language/DB version.
[ ] Type hints / static typing are correct (if used in the programming language).
[ ] No hallucinated APIs/keywords (non-existent APIs or syntax).
[ ] Import / using / include statements are correct and complete (for programming).
[ ] Exception / Error handling is appropriate for the context (no overly broad try/catch).
[ ] No deprecated code/queries without clear notes.
[ ] Code complies with the language's style guide.
[ ] Each code block declares its language (e.g., ```rust, ```csharp, ```python, ```sql, ```javascript).
````

### B. Pedagogy [REQUIRED]

```
[ ] Concepts are explained BEFORE code examples.
[ ] Explanations are level-appropriate (begin/advance/master).
[ ] No assumption of knowledge beyond the level (especially for begin).
[ ] At least 2 code examples are provided.
[ ] The first example is the simplest, followed by more complex ones.
[ ] A Common Mistakes section is included with at least 2 mistakes.
[ ] A Best Practices section is included with at least 2 points.
[ ] Exactly 1 clear Mini Exercise is included (with sample input and expected output). Multiple exercises are not allowed.
[ ] A Summary is included at the end of the section (3–5 bullet points).
```

### C. Markdown & Docusaurus Formatting [REQUIRED]

```
[ ] YAML frontmatter is complete in Docusaurus format (id, title, sidebar_label, sidebar_position, level, lesson_id, section_id, language_version, review_score, status).
[ ] Uses Docusaurus Admonitions (:::note, :::tip, :::info, :::warning, :::danger) instead of GitHub-style (> [!NOTE]).
[ ] MDX Safety: No raw HTML-like tags (such as <T>, <string>) in plain text. All must be in code blocks, inline code, or escaped.
[ ] Heading order follows style_guide.md (read from `./style_guide.md` in the current working directory) Section 9.1 exactly (in English for English courses; translated to Vietnamese if course_language is "vi").
[ ] No custom second-level headings (##) are used in the section file; all custom subheadings must be level-3 (###) or level-4 (####) under the main concepts section ("Khái niệm cốt lõi" if "vi", "Main Concepts" if "en" or default).
[ ] Heading levels are not skipped (e.g., no going from ## straight to ####).
[ ] Code blocks use triple backticks with the specified language.
[ ] No broken links.
[ ] Tables are formatted correctly in Markdown.
[ ] No duplicate headings within a section.
```

### D. Content [REQUIRED]

```
[ ] Filename follows file_naming_convention.md exactly.
[ ] Terminology is consistent throughout the section.
[ ] No content copied verbatim from external sources.
[ ] Written in the target course language specified by course_language in state.md (Vietnamese if "vi", English if "en" or default).
[ ] Uncertain information is marked with a REQUIRES VERIFICATION tag.
[ ] References section is included (at least 1 source).
```

### E. Review Score [REQUIRED]

```
[ ] Self-reviewed according to review_instruction.md.
[ ] review_score is populated in the YAML frontmatter.
[ ] review_score >= 8.0.
[ ] status: approved (only when score >= 8.0).
[ ] Review JSON file has been saved to output/reviews/sections/.
```

### F. Optional Quality [OPTIONAL]

```
[ ] Analogies or visual illustrations are provided for complex concepts.
[ ] Code examples have practical value (not just Hello World).
[ ] Exercises have multiple difficulty levels (basic / advanced).
[ ] Hints are provided for exercises without giving away the solution.
```

---

## Checklist 2: Before Merging a Lesson

### A. Prerequisites [REQUIRED]

```
[ ] All section files exist in output/sections/{level}/.
[ ] All sections have status: approved.
[ ] All sections have review_score >= 8.0.
[ ] Consecutive Section IDs are not missing (S01, S02, S03...).
[ ] Read template_lesson.md (from `./template_lesson.md` in the current working directory).
```

### B. Lesson Structure [REQUIRED]

```
[ ] YAML frontmatter of the lesson is complete in Docusaurus format (id, title, sidebar_label, sidebar_position, ...).
[ ] Lesson Introduction section is included using Docusaurus admonition format (including learning objectives, prerequisites, and estimated time).
[ ] Lesson level headings follow style_guide.md (read from `./style_guide.md` in the current working directory) Section 9.2 exactly (in English for English courses; translated to Vietnamese if course_language is "vi").
[ ] Sections are arranged in the correct order (S01 → S02 → ...) and sidebar_position corresponds.
[ ] Lesson Recap section is included at the end of the lesson.
[ ] At least 2 Comprehensive Exercises are included.
[ ] Quiz is included (5 questions, with hidden answers in <details> tags).
```

### C. Content Processing [REQUIRED]

```
[ ] Clear duplicate content between sections has been removed.
[ ] Terminology is consistent throughout the lesson.
[ ] Transition text (1-2 sentences leading from one section to the next) is added between all section boundaries (do not leave empty spaces).
[ ] Useful code examples are not deleted even if they seem similar.
[ ] Code meaning is not changed during editing.
```

### D. Lesson Formatting [REQUIRED]

```
[ ] Lesson filename follows file_naming_convention.md exactly.
[ ] Heading hierarchy is correct (all merged section headings are shifted to level-3 ### headings under their respective section title).
[ ] All section IDs and titles in YAML frontmatter match the actual content.
[ ] No broken links or incorrect references.
```

### E. Comprehensive Exercises [REQUIRED]

```
[ ] At least 2 exercises combining knowledge from multiple sections.
[ ] Each exercise has: title, description, sample input, expected output.
[ ] Difficulty gradually increases between exercises.
[ ] Exercises match the level of the lesson.
```

### F. Quiz [REQUIRED]

```
[ ] Exactly 5 questions.
[ ] Each question has exactly 4 options (A, B, C, D).
[ ] Only 1 correct option per question.
[ ] Answer is inside <details> tag (hidden).
[ ] Brief explanation is provided for the correct answer.
[ ] Distribution: 2 theoretical questions, 2 code-reading questions, 1 debug question.
```

---

## Checklist 3: Advanced Language-Specific Techniques (For Advance and Master Levels)

Apply additionally to all sections/lessons at `advance` or `master` level. These checks complement
Checklist 1 and focus on depth of coverage expected at higher levels.

```
[ ] Advanced type system features are demonstrated correctly (generics, type parameters, associated types, protocols, interfaces — as applicable to the language).
[ ] Performance implications are discussed (time complexity, memory allocation, stack vs. heap, zero-cost abstractions where relevant).
[ ] Concurrency and thread-safety considerations are explicitly stated when the topic involves shared state, async operations, or parallel execution.
[ ] At least one alternative approach or pattern is compared against the primary approach shown, with a rationale for when to prefer each.
[ ] Code examples are not simplified to the point of being unrealistic; they reflect production-quality usage patterns.
[ ] Relevant language specifications, standards, or official RFCs (e.g., PEP, RFC, ECMA spec, language reference) are cited when explaining design decisions.
[ ] Error handling follows language-idiomatic patterns (e.g., Result/Option for Rust, checked exceptions for Java, error values for Go) — not generic try/catch where avoidable.
[ ] Ownership, memory safety, or resource management implications are described where the language enforces or encourages specific patterns.
[ ] If unsafe or low-level constructs are shown, a SAFETY comment or invariant explanation is included.
```

---

## Checklist 4: Level-Specific

### Level Begin

```
[ ] Programming: Complex structures (list comprehension, lambda, decorator...) are not used without prior explanation.
[ ] Database: Complex subqueries/joins are not used without prior explanation.
[ ] Each new concept has an easy-to-understand analogy.
[ ] No assumption of prior knowledge about OOP or RDBMS Architecture.
```

### Level Advance

```
[ ] Explained WHY (why use this pattern), not just HOW.
[ ] Edge cases and handling methods are mentioned.
[ ] Realistic examples are included (not just simplified examples).
[ ] Testing is mentioned if appropriate.
```

### Level Master

```
[ ] Performance is discussed (time/space complexity when relevant).
[ ] Runtime architecture or compiler internals of the target language are mentioned where they explain the behavior demonstrated in examples.
[ ] At least two patterns or approaches are compared with explicit trade-off analysis.
[ ] Code examples are at a production-ready level (not toy programs).
[ ] Maintainability and scalability considerations are discussed.
[ ] The section explains not just HOW but WHY the language or runtime behaves this way at a fundamental level.
```

---

## Quick Summary

Before saving, answer these 3 questions:

> 1. **Is the code syntax correct (and runnable for programming languages)?** If not → Fix it first.
> 2. **Is the review score >= 8.0?** If not → Fix it first.
> 3. **Are all REQUIRED checklist items ticked?** If not → Fix it first.

Only save when all 3 answers are **YES**.
