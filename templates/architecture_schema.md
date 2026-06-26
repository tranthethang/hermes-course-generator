# Architecture File Schema

This document defines the exact formatting and structure required for the `architecture.md` file in a course workspace. The CLI tool uses regex pattern matching to parse this file, so adhering strictly to this schema is essential.

## Expected Format

The architecture file is structured hierarchically by course levels, lessons, and sections.

### 1. Level Declaration
Each level must be declared on its own line using a Level-2 Markdown heading:
```markdown
## Level: [begin|advance|master]
```
- Allowed levels are: `begin`, `advance`, or `master` (case-insensitive).
- Spaces around the colon are optional but recommended.
- Example: `## Level: begin`

### 2. Lesson Declaration
Lessons within a level must be declared using a Level-3 Markdown heading:
```markdown
### Lxx: [Lesson Title]
```
- `Lxx` must be the lesson ID starting with a capital `L` followed by exactly two digits (e.g. `L01`, `L02`, `L12`).
- The colon `:` is required.
- Example: `### L01: Introduction to Programming`

### 3. Section Declaration
Sections within a lesson must be declared using a bullet point list item:
```markdown
- Sxx: [Section Title]
```
- `Sxx` must be the section ID starting with a capital `S` followed by exactly two digits (e.g. `S01`, `S02`).
- The colon `:` is required.
- Example: `- S01: Variables and Data Types`

---

## Working Example

Below is a complete, valid example of an `architecture.md` file:

```markdown
# Course Architecture

## Level: begin

### L01: Introduction to Programming
- S01: What is Programming
- S02: Setting Up the Environment
- S03: Writing Your First Code

### L02: Control Flow
- S01: If-Else Statements
- S02: Switch Statements

## Level: advance

### L03: Object-Oriented Programming
- S01: Classes and Objects
- S02: Inheritance and Polymorphism
```

---

## Syntax Validation Rules and Common Pitfalls

The parser in the CLI relies on the following regular expressions:
- Level match: `^##\s*(Level\s*:\s*)?(begin|advance|master)\b`
- Lesson match: `^###\s*(L\d{2}):\s*(.*)$`
- Section match: `^-\s*(S\d{2}):\s*(.*)$`

### What Breaks the Parser:
1. **Wrong Level Header Depth:** Using `# Level: begin` or `### Level: begin` instead of `## Level: begin`.
2. **Incorrect Spacing or Missing Colons:**
   - Writing `### L01 Introduction` instead of `### L01: Introduction`.
   - Writing `- S01 Variables` instead of `- S01: Variables`.
3. **Invalid ID Formats:**
   - Single-digit IDs (e.g., `L1` instead of `L01`, `S2` instead of `S02`).
   - Lowercase prefix (e.g., `l01` or `s02`).
4. **Nested bullet spacing:** Adding extra indent spaces before the bullet point (e.g., `  - S01:` instead of `- S01:`). The section match expects the bullet point to start at the beginning of the line or after minimal whitespace.
5. **No Level Prefix:** Declaring lessons before defining a level block. These lessons will not be associated with any level and may be ignored or skipped by level-specific status checks.
