# File Naming Convention

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Rules for file naming, slug creation, and output directory structure in the project.

---

## 1. Slugification Rules

A slug is a string used as a filename that is friendly to the filesystem and URLs.

### Mandatory slug creation rules:

1. **Convert to lowercase:** Do not capitalize any characters.
2. **Remove Vietnamese diacritics:** Convert accented characters to non-accented equivalents (e.g.,
   `đ` -> `d`, `á` -> `a`, `ơ` -> `o`).
3. **Replace spaces with hyphens (`-`):** Do not use spaces or underscores (`_`) in the slug.
4. **Remove special characters:** Delete all characters such as `?`, `!`, `,`, `.`, `:`, `/`, `(`,
   `)`, `"`, `'`...
5. **Only keep lowercase letters (a-z), digits (0-9), and hyphens (-).**

### Conversion Examples:

- `"Concept of Variables & Value Assignment!"`  
  -> `concept-of-variables-and-value-assignment`
- `"Working with f-string (Python 3.12+)"`  
  -> `working-with-f-string-python-312`
- `"Advanced Decorator & OOP"`  
  -> `advanced-decorator-and-oop`

---

## 2. File Naming Rules

### 2.1 For Section (Small Lesson)

Format:

```
{lesson_id}_{section_id}_{slug}.mdx
```

- `{lesson_id}`: Format `L` + 2 digits (e.g., `L01`, `L12`).
- `{section_id}`: Format `S` + 2 digits (e.g., `S01`, `S05`).
- `{slug}`: Slug created from the section title.

Specific examples:

- `L01_S01_concept-of-variables-and-value-assignment.mdx`
- `L02_S03_closures-and-nonlocal-variables.mdx`

### 2.2 For Lesson (Large Lesson - After Merging)

Format:

```
{lesson_id}_{slug}.mdx
```

- `{lesson_id}`: Format `L` + 2 digits.
- `{slug}`: Slug created from the lesson title.

Specific examples:

- `L01_variables-and-basic-data-types.mdx`
- `L02_functions-and-variable-scopes.mdx`

### 2.3 For Review Files (Quality Assessment)

#### A. Section Review

Format:

```
{lesson_id}_{section_id}_review.json
```

Specific examples:

- `L01_S01_review.json`
- `L02_S03_review.json`

#### B. Lesson Review

Format:

```
{lesson_id}_review.json
```

Specific examples:

- `L01_review.json`

---

## 3. Directory Structure under `output/`

All output files must be placed precisely in the following subdirectories. Hermes is responsible for
automatically creating these directories if they do not already exist.

```text
output/
├── changelog.md                       # Overall changelog of the project
├── sections/                          # Stores individual section files
│   ├── begin/                         # Beginner level sections
│   ├── advance/                       # Intermediate level sections
│   └── master/                        # Master level sections
├── lessons/                           # Stores fully merged lesson files
│   ├── begin/
│   ├── advance/
│   └── master/
└── reviews/                           # Stores quality reviews (JSON)
    ├── sections/                      # Reviews for individual sections
    │   ├── begin/
    │   ├── advance/
    │   └── master/
    └── lessons/                       # Reviews for merged lessons
        ├── begin/
        ├── advance/
        └── master/
```

### Sample File Saving Map:

- If creating Section `L01_S01` for level `begin`: -> Save to:
  `output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx`
- If saving review for Section `L01_S01` level `begin`: -> Save to:
  `output/reviews/sections/begin/L01_S01_review.json`

- If merging Lesson `L01` for level `begin`: -> Save to:
  `output/lessons/begin/L01_variables-and-basic-data-types.mdx`

- If saving review for Lesson `L01` level `begin`: -> Save to:
  `output/reviews/lessons/begin/L01_review.json`
