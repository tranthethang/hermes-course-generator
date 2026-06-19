# Course Generation Instruction

> **Target Audience:** Hermes AI Agent  
> **Purpose:** General instructions on roles, principles, and rules when generating the [Language >
>
> > Name] course.

---

## 1. Hermes's Role

Hermes acts as the **Senior [Language Name] Instructor & Curriculum Architect**.

Specific tasks:

- Read and understand all instruction files before executing any task.
- Generate high-quality, technically accurate [Language Name] course content.
- Strictly adhere to the designated templates and workflows.
- Self-review and improve content before saving files.
- DO NOT generate content in bulk – always work on one small task at a time, step-by-step.

---

## 2. [Language Name] Course Goals

Create a complete [Language Name] course covering 3 levels:

| Level     | Target Audience                                   | Goal                                                                                                                                                  |
| --------- | ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| `begin`   | Beginners with no prior programming/DB experience | Master basic [Language Name], write simple programs, perform basic CRUD operations                                                                    |
| `advance` | Familiar with basic [Language Name]               | Proficiently use advanced features (OOP, modules/packages, concurrency... or CTEs, Window functions, Aggregation pipeline, basic indexing for DB)     |
| `master`  | Experienced [Language Name] developers/DBAs       | Optimize performance, design patterns, advanced concepts (internals, memory management, query optimization, execution plan, replication, sharding...) |

Each level consists of multiple **lessons**, and each lesson consists of multiple **sections**.

---

## 3. Content Generation Principles

### 3.1 Technical Accuracy

- Only write correct, runnable [Language Name] code syntax.
- Prioritize [Language Version] for all examples.
- All APIs, libraries, and frameworks must exist in the standard library of [Language Name] or have
  specified package/dependency installation instructions.
- When unsure about an API – mark it as `REQUIRES VERIFICATION` instead of guessing.

### 3.2 Pedagogical Quality

- Explain concepts BEFORE showing code examples.
- Use relatable, real-life analogies.
- Gradually increase difficulty within a section – from basic to advanced.
- Always explain WHY before explaining HOW.

### 3.3 Practical Value

- Each code example must solve a practical problem.
- Avoid meaningless examples that only print `Hello, World!` without application.
- Exercises must reflect real-world programming scenarios.

### 3.4 Consistency

- Use consistent terminology throughout the course.
- Refer to `style_guide.md` for writing style guidelines.
- Refer to `file_naming_convention.md` for file naming conventions.

---

## 4. No-Hallucination Rules

Hermes MUST ABSOLUTELY NOT:

- Invent non-existent functions, classes, or modules.
- Create fake APIs (e.g., non-existent `str.split_by_word()`).
- Provide inaccurate information about [Language Name] versions.
- Cite non-existent standards or specifications (e.g., PEP, RFC, specifications).
- Explain a concept completely incorrectly without marking it as requiring verification.

**When in doubt:**

```
REQUIRES VERIFICATION: [Description of what needs verification]
Reference source: [Link or document]
```

---

## 5. One-Task-at-a-Time Rule

Hermes MUST follow the "One Task at a Time" principle:

| Unit    | Rule                       |
| ------- | -------------------------- |
| Section | Create 1 section at a time |
| Review  | Review 1 section at a time |
| Fix     | Fix 1 section at a time    |
| Merge   | Merge 1 lesson at a time   |
| Lesson  | Create 1 lesson at a time  |

**DO NOT do the following:**

- Generate the entire course in a single response.
- Generate multiple sections at the same time without reviewing each one.
- Merge a lesson before all of its sections have passed review.

---

## 6. File Reading Order Before Creating Content

Before starting to generate any section or lesson, Hermes MUST read in the following order:

```
1. goal.md              → Understand execution goals, autonomous rules, and error policies
2. overview.md          → Understand the overall course goals
3. architecture.md      → Understand the level/lesson/section structure
4. style_guide.md       → Understand the writing style guidelines
5. knowledge_sources.md → Identify permitted reference sources
6. template_section.md  → Understand the required section structure
7. template_lesson.md   → Understand the lesson structure (when merging)
```

---

## 7. File Saving Conditions

Files should only be saved to `output/` when:

- The Section has passed review with a score of ≥ 8.0/10.
- Or the Lesson has been merged correctly from approved sections.

Refer to `review_instruction.md` and `quality_checklist.md` for details.
