# Style Guide

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Guidelines for course writing style, code formatting, and course content generation
> (supporting both English and Vietnamese).

---

## 1. English Writing Style

### 1.1 General Principles

| Principle                     | Description                                                                  |
| ----------------------------- | ---------------------------------------------------------------------------- |
| **Friendly, not rigid**       | Write as if explaining directly, not like a dry textbook.                    |
| **Professional**              | Avoid slang or unnecessary jargon.                                           |
| **Clear rather than flowery** | Short sentences, clear ideas, avoid rambling sentences.                      |
| **Active voice**              | Use active constructs (e.g. "you will learn"), not passive ones.             |
| **No Emojis**                 | Do not use emojis in headings, lists, inline text, code blocks, or comments. |

### 1.2 Pronouns

- Address the reader directly as **"you"** (not "the learner", "students").
- Hermes addresses itself as **"we"** when explaining concepts together; do not use "I".
- Example: "We will explore..." instead of "I will explain...".

### 1.3 Sentence Structure

**Prefer:**

- Short sentences, maximum of 20–25 words per sentence.
- Each paragraph: 3–5 sentences.
- Start with the concept, end with an example or action.

**Avoid:**

- Passive voice: [INCORRECT] "Variables are used to store..." -> [CORRECT] "Variables store..."
- Long sentences with multiple clauses: [INCORRECT] "[Language Name] is a powerful, flexible,
  easy-to-learn programming language that is widely used for..."
- Filler words: [INCORRECT] "Actually..." "Basically..." "Simply put..."
- Emojis and decorative symbols: [INCORRECT] Using emojis in headings, lists, inline text, or code
  comments. Always write in plain text.

### 1.4 Writing Examples

**Do not write like this (INCORRECT):**

> "A [Data Type] is a data type in [Language Name] that allows storing elements..."

**Write like this (CORRECT):**

> "A list is like a box containing multiple items. You can put numbers, strings, or even other lists
> inside. And you can change the contents of the box at any time."

---

## 2. Technical Terminology

- All programming language names, syntax keywords, and functions must be written exactly as they are
  defined in the language (e.g., `Python`, `struct`, `class`, `print()`, `unwrap()`).
- Always write technical terms in code blocks (e.g., `closure`, `decorator`, `interface`) to keep
  them distinct from normal text.
- Explain complex concepts upon their first appearance in a section (e.g., "a `closure` (an inner
  function that remembers outer variables)").

---

## 3. Concept Presentation Structure

**Mandatory order:**

```
1. Explain "what it is" in natural language
2. Use a real-world analogy (if applicable)
3. Explain why it is needed
4. Provide the simplest code example
5. Expand with a more realistic example
6. Mention special cases or common mistakes
7. State best practices
```

---

## 4. Code Sample Rules

### 4.1 Mandatory Standards (Examples for Python/SQL/MongoDB)

**For programming languages (e.g., Python):**

```python
# Python 3.12+
# Always declare the language version at the beginning of the file or first code block (if necessary)

# Use the standard and most modern syntax of the language (e.g., type hints)
def calculate_area(length: float, width: float) -> float:
    """Calculate the area of a rectangle."""
    return length * width

# Variable names must be descriptive and in English
student_name = "Alice"

# Explanation comments in English
numbers = [1, 2, 3, 4, 5]  # A list containing 5 integers
```

**For databases (e.g., SQL):**

```sql
-- PostgreSQL 15+
-- Single-line comment starts with --
-- Get top 5 employees with highest salary
SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE department = 'Engineering'
ORDER BY salary DESC
LIMIT 5;
```

**For databases (e.g., MongoDB):**

```javascript
// MongoDB 6.0+
// Comments explaining the query purpose
// Find users in Vietnam, sorted by registration date descending
db.users
  .find({ country: "Vietnam" }, { username: 1, email: 1, registered_at: 1, _id: 0 })
  .sort({ registered_at: -1 })
  .limit(10);
```

### 4.2 Commenting Rules

- Comments must explain **why**, not **what** (the code already tells what).
- Each code example needs at least 2–3 comments.
- Use `#` for inline comments, docstrings `"""` for functions/classes.

```python
# INCORRECT: Meaningless comment
x = x + 1  # Increment x by 1

# CORRECT: Valuable comment
x = x + 1  # Offset by 1 because index starts at 0
```

### 4.3 Code Block Formatting

Always declare the language corresponding to code blocks (e.g. `rust`, `python`, `go`):

````markdown
```python
# Code goes here
```
````

When comparing correct/incorrect code (Example in Python):

```python
# INCORRECT
result = [x for x in range(10) if x % 2 = 0]  # SyntaxError

# CORRECT
result = [x for x in range(10) if x % 2 == 0]
```

### 4.4 Style Guide / Naming Conventions

- Adhere to naming conventions of the language being taught (e.g., `camelCase` for Java/JavaScript;
  `snake_case` for Python/Rust; `PascalCase` for C#).
- Variables/functions/tables/columns: Adhere to standards (e.g., `snake_case` for Python and SQL
  tables).
- Classes/structs/types: Usually `PascalCase`.
- Constants: Usually `UPPER_SNAKE_CASE`.
- SQL Keywords: MUST be written in UPPERCASE (`SELECT`, `FROM`, `WHERE`).
- Formatting: Use standard code formatters. For SQL, ensure line breaks for each major clause.

### 4.5 Code Must Be Runnable

Every code block (for programming) must be immediately runnable. If external libraries are needed,
declare them clearly (Example in Python):

```python
# Install: pip install requests
import requests

response = requests.get("https://api.example.com/data")
print(response.status_code)
```

**Note:** For SQL and MongoDB, only syntax correctness is required; running environments are not
mandatory for reviews.

---

## 5. Rules for Writing Examples

### 5.1 Examples Must Be Realistic

| Avoid (INCORRECT)                     | Should Use (CORRECT)                                  |
| ------------------------------------- | ----------------------------------------------------- |
| `foo`, `bar`, `baz` as variable names | `student_scores`, `product_prices`                    |
| `x = 10` without context              | `age = 25  # User's age`                              |
| Vague function declarations           | Function declarations with clear names and type hints |
| Printing `Hello World`                | Processing real-world data (names, scores, prices...) |

### 5.2 Gradually Increasing Complexity

Within a section, examples must progress from simple to complex:

```
Example 1: The most basic case
Example 2: Adding a realistic scenario
Example 3 (if any): Combined with other concepts or edge cases
```

---

## 6. Rules for Writing Exercises

### 6.1 Mandatory Structure

```markdown
### Exercise: [Clear Exercise Title]

**Requirements:** Specific, non-ambiguous description. State clearly:

- What the Input is
- What the Output is
- Special conditions (if any)

**Example:**

- Input: `[1, 2, 3, 4, 5]`
- Output: `[1, 4, 9, 16, 25]`

**Hint (Optional):**

- Use language-specific features (e.g. list comprehension in Python, `map` in Rust, LINQ in C#)

**Level:** Basic / Advanced
```

### 6.2 Exercise Rules

- DO NOT provide solutions in the section's exercise.
- Exercises must test the EXACT knowledge taught in the section.
- Lesson-level exercises (in the Comprehensive section) must combine multiple sections.

---

## 7. Rules for Writing Quizzes

````markdown
### Question [N]: [Clear, unambiguous question (Example in Python)]

```python
# Code for code-reading question (if any)
x = [1, 2, 3]
print(x[-1])
```
````

- A) `1`
- B) `2`
- C) `3`
- D) `IndexError`

<details>
<summary>View Answer</summary>

**Answer: C) `3`**

Explanation: Index `-1` in Python refers to the last element of the list. (When writing for other
languages, adapt the examples and explanations accordingly).

</details>
```

Quiz rules:

- Questions must have exactly 4 clear options.
- ONLY 1 correct option per question.
- Incorrect options must be "plausible" – not obviously wrong.
- Always provide a short explanation in the answer details.

---

## 8. Docusaurus & MDX Compatibility Rules

When writing lesson docs, you must comply with Docusaurus MDX rules to prevent compile and display
errors:

### 8.1 Avoid MDX Safety Errors (Characters `<`, `>`, `{`, and `}`)

- The Docusaurus MDX parser will misinterpret `<` and `>` characters standing alone (or inside
  generic formats like `<int>`, `<string>`, `<T>`) as unclosed HTML/JSX tags.
- Similarly, curly braces `{` and `}` standing alone (or inside formatting syntax like `{tên}`,
  `{giá_trí}`) are interpreted by the parser as JavaScript/JSX expressions. If they are not valid
  JavaScript or refer to undefined variables, they will fail the build.
- **Rule:** You must wrap these characters, generic types, or literal braces in inline code (e.g.,
  `` `<string>` ``, `` `{tên}` ``) or use escape characters (`\<int\>`, `\{tên\}`).
- **Examples of Incorrect vs Correct Usage:**
  - **Incorrect (will fail compilation):**
    - `# Box<T>: Heap Allocation`
    - `### Rc<RefCell<T>>: Shared Mutable Data`
    - `Result is always >= min and <= max`
    - `Xin chào {tên}, bạn {tuổi} tuổi`
    - `In kết quả dạng: {giá_trí:.1f}`
  - **Correct (compiled successfully):**
    - `# Box\<T\>: Heap Allocation` (escaped) or `# Box<T>: Heap Allocation` (backticks)
    - `### Rc\<RefCell\<T\>\>: Shared Mutable Data` (escaped) or
      `### Rc<RefCell<T>>: Shared Mutable Data` (backticks)
    - `Result is always \>= min and \<= max` (escaped) or `Result is always >= min and <= max`
      (backticks)
    - `Xin chào \{tên\}, bạn \{tuổi\} tuổi` (escaped) or `Xin chào {tên}, bạn {tuổi} tuổi`
      (backticks)
    - `In kết quả dạng: \{giá_trí:.1f\}` (escaped) or `In kết quả dạng: {giá_trí:.1f}` (backticks)

### 8.2 Use Admonitions

Do not use GitHub markdown syntax (e.g. `> [!NOTE]`). Instead, use Docusaurus Admonitions:

```markdown
:::note Title (Optional) Note content goes here. :::

:::tip Useful tip goes here. :::

:::info Information goes here. :::

:::warning Warning goes here. :::

:::danger Danger/critical error warning goes here. :::
```

### 8.3 MDX Comment Rules

- Do NOT use HTML comments `<!-- comment -->`.
- MDX only supports JSX-style comments: `{/* comment */}`.
- Example: `{/* TRANSITION_BEFORE_S01 */}` instead of `<!-- TRANSITION_BEFORE_S01 -->`.

---

## 9. Standard Course Headings (Language Specific)

To maintain consistency across all lessons and sections, all generated files must use the exact
headings listed below. Custom second-level headings (using `##`) are strictly prohibited in section
files. Any additional subtopics or custom headers must use third-level (`###`) or fourth-level
(`####`) headings under the main concepts section ("Khái niệm cốt lõi" in Vietnamese, or "Main
Concepts" in English).

- For **English** courses (`course_language: "en"` or default): Use the English Template Headings.
- For **Vietnamese** courses (`course_language: "vi"`): Use the Required Vietnamese Translations.

### 9.1 Section Headings

| English Template Heading | Required Vietnamese Translation | Purpose                             |
| ------------------------ | ------------------------------- | ----------------------------------- |
| Introduction             | Giới thiệu                      | Context and analogies               |
| Main Concepts            | Khái niệm cốt lõi               | Theory and custom subheadings (###) |
| Code Examples            | Ví dụ minh họa                  | Practical code blocks               |
| Common Mistakes          | Lỗi thường gặp                  | Incorrect vs correct code           |
| Best Practices           | Thực hành tốt nhất              | Style and performance tips          |
| Mini Exercise            | Bài tập nhỏ                     | Exactly one exercise                |
| Summary                  | Tóm tắt                         | Bullet points wrap-up               |
| References               | Tài liệu tham khảo              | Official documentation links        |

### 9.2 Lesson Headings (Merged File)

| English Template Heading | Required Vietnamese Translation | Purpose                         |
| ------------------------ | ------------------------------- | ------------------------------- |
| Lesson Introduction      | Giới thiệu bài học              | Learning goals and requirements |
| Lesson Recap             | Tóm tắt bài học                 | Overall summary                 |
| Comprehensive Exercises  | Bài tập tổng hợp                | Exercises combining sections    |
| Quiz                     | Trắc nghiệm                     | Self-assessment questions       |

All merged sections in the lesson file will have their headings automatically shifted down to
third-level (`###`) headings under their respective section titles (e.g., `## Giới thiệu`,
`## Khái niệm cốt lõi` under the main section title `## [Section Name]`).
