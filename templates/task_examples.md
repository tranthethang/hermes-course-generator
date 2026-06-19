# Task Examples

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Provide realistic examples for each type of task (Generate Section, Review Section,
> Fix Section, Merge Lesson, Generate Changelog).

---

## 1. Example Task 1: Generate Section (Task: generate_section)

### User Request

```
Please generate Section S01 for Lesson L01 level "begin".
Lesson Title: "Variables and Basic Data Types"
Section Title: "Concept of Variables and Value Assignment"
```

### Hermes's Realistic Response (After running workflow)

`````markdown
# Execution progress: generate_section (begin - L01_S01)

1. Read `overview.md`, `architecture.md` to get context.
2. Identified level: `begin` (no prior programming knowledge assumed).
3. Looked up Python 3.12 documentation on assignment and variable naming.
4. Self-reviewed and fixed 1 issue: added a missing realistic code example.

---

### File content written: `output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx`

````markdown
---
level: begin
lesson_id: L01
lesson_title: "Variables and Basic Data Types"
section_id: S01
section_title: "Concept of Variables and Value Assignment"
language_version: "3.12+"
review_score: 8.8
status: approved
---

# Concept of Variables and Value Assignment

## Introduction

In programming, we always need to store information to reuse it later. Imagine you are managing an
online store; you need to remember the price of a product or a customer's name. That is why we need
**Variables**.

## Core Concepts

A variable is like a labeled box. The label of the box is the **Variable Name**, and the item inside
the box is the **Variable Value**.

Assignment in Python uses the equals sign (`=`). It means: "Take the value on the right and place it
inside the box named on the left".

## Code Examples

```python
# Python 3.12+

# 1. Declare variables to store a student's name and age
student_name: str = "Alice"
student_age: int = 15

print(student_name)  # Output: Alice
print(student_age)   # Output: 15

# 2. Change the value of a variable (re-assign a new value)
stock_quantity: int = 10
stock_quantity = stock_quantity - 2
print(stock_quantity)  # Output: 8
```
````
`````

## Common Mistakes

### 1. Reversing assignment direction

Beginners often confuse the left-hand side and right-hand side.

```python
# INCORRECT
15 = age  # SyntaxError: cannot assign to literal here

# CORRECT
age = 15
```

### 2. Using a variable before declaring it

You cannot retrieve something from a box that does not exist yet.

```python
# INCORRECT
print(score)  # NameError: name 'score' is not defined

# CORRECT
score = 9.5
print(score)
```

## Best Practices

- **Use meaningful variable names:** Use `book_count` instead of `x` or `bc`.
- **Follow PEP 8:** Use lowercase and underscores (snake_case) for variable names. For example,
  `username`.
- **Use Type Hints:** Annotate variable types to make your code clearer (e.g., `age: int = 18`).

## Mini Exercise

**Requirements:** Write a program that declares 3 variables: `product_name`, `price`, and
`quantity`. Then, calculate the total amount (price multiplied by quantity) and assign it to a
variable named `total_amount`. Finally, print `total_amount` to the screen.

- Sample Input: `product_name = "Python Book"`, `price = 50000`, `quantity = 3`
- Expected Output: `150000`

## Summary

- Variables are used to store data in memory.
- Variable assignment syntax: `variable_name = value`.
- Variable names should be lowercase, use snake_case, and be descriptive.

## References

- [Python Docs: Informal Introduction to Python - Variables](https://docs.python.org/3/tutorial/introduction.html#numbers)
- [PEP 8 - Naming Conventions](https://peps.python.org/pep-0008/#naming-conventions)

```

**Self-review report:**

- Technical Accuracy: 9.0/10 (Code runs fine, type hints included)
- Teaching Quality: 9.0/10 (relatable storage box analogy)
- Example Quality: 8.5/10 (2 practical examples included)
- Exercise Quality: 8.5/10 (Practical exercise with clear input/output)
- Format Compliance: 9.0/10 (Completely matches template)
- **Total weighted score: 8.8/10 (APPROVED)**
```

`````

---

## 2. Example Task 2: Review Section (Task: review_section)

### User Request

```
Please review the following section file: output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx
```

### Hermes's Realistic Response (Writes JSON review file)

```json
{
  "review_type": "section",
  "target_file": "output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx",
  "review_timestamp": "2026-06-18T13:52:00+07:00",
  "scores": {
    "technical_accuracy": {
      "score": 9.0,
      "weight": 0.3,
      "notes": "Code is completely accurate to Python 3.12+ style. No syntax errors."
    },
    "teaching_quality": {
      "score": 9.0,
      "weight": 0.25,
      "notes": "Excellent visual explanation for absolute beginners."
    },
    "example_quality": {
      "score": 8.0,
      "weight": 0.2,
      "notes": "Good examples, but Example 2 (re-assignment) should include a detailed explanation of the right-to-left execution flow."
    },
    "exercise_quality": {
      "score": 8.0,
      "weight": 0.15,
      "notes": "Appropriate exercise, but could clarify that students do not need to wrap this in a function for this basic stage."
    },
    "format_compliance": {
      "score": 10.0,
      "weight": 0.1,
      "notes": "All YAML metadata and headings are present."
    }
  },
  "total_score": 8.75,
  "result": "APPROVED",
  "strengths": [
    "Used a relatable storage box analogy that is very visual.",
    "Common mistakes are selective and address real issues beginners face."
  ],
  "weaknesses": [
    "The explanation of Example 2's variable re-assignment (`stock_quantity = stock_quantity - 2`) fails to detail that the computer evaluates the right side first before overwriting the left side."
  ],
  "required_fixes": [
    {
      "priority": "low",
      "location": "## Code Examples > Example 2",
      "issue": "Missing explanation of the self-referencing variable assignment flow.",
      "fix": "Add a short explanation: 'This statement works by taking the current value of stock_quantity (10), subtracting 2 to get 8, and then storing 8 back into the same box.'"
    }
  ]
}
```

---

## 3. Example Task 3: Fix Section (Task: fix_section)

### User Request

```
Please fix the section L01_S01 based on the corresponding JSON review file.
```

### Hermes's Realistic Response (After fixing and writing the file)

````markdown
# Execution progress: Fix section L01_S01 according to review

1. Read the review file `output/reviews/sections/begin/L01_S01_review.json`.
2. Identified the fix: Add explanation for the self-referencing variable assignment in Example 2.
3. Applied the code and text modifications.
4. Re-ran self-review.

---

### Code Diff:

```diff
 # 2. Change the value of a variable (re-assign a new value)
- stock_quantity: int = 10
- stock_quantity = stock_quantity - 2
+ stock_quantity: int = 10
+ stock_quantity = stock_quantity - 2
+# Explanation: The computer calculates the right-hand side first (10 - 2 = 8), then overwrites stock_quantity with 8.
- print(stock_quantity)  # Output: 8
+ print(stock_quantity)  # Output: 8
```

---

**Re-review Report:**

- File updated successfully.
- New review score: **8.9/10** (increased due to improved example explanation).
- Status: **approved**.
- Changelog updated.

```

```
`````

---

## 4. Example Task 4: Merge Lesson (Task: merge_lesson)

### User Request

```
Please merge the sections of Lesson L01 level "begin" into a complete lesson file.
```

### Hermes's Realistic Response

`````markdown
# Execution progress: merge_lesson (begin - L01)

1. Checked section file statuses:
   - `L01_S01_concept-of-variables-and-value-assignment.mdx` -> APPROVED (Score: 8.9)
   - `L01_S02_numbers-and-strings.mdx` -> APPROVED (Score: 9.0)
   - `L01_S03_basic-input-output.mdx` -> APPROVED (Score: 8.5)
2. No duplicate examples detected. Added Lesson Introduction, Lesson Recap, Comprehensive Exercises,
   and Quiz.

---

### File content written: `output/lessons/begin/L01_variables-and-basic-data-types.mdx`

````markdown
---
level: begin
lesson_id: L01
lesson_title: "Variables and Basic Data Types"
section_count: 3
sections:
  - id: S01
    title: "Concept of Variables and Value Assignment"
    file: "L01_S01_concept-of-variables-and-value-assignment.mdx"
  - id: S02
    title: "Numbers and Strings"
    file: "L01_S02_numbers-and-strings.mdx"
  - id: S03
    title: "Basic Input and Output"
    file: "L01_S03_basic-input-output.mdx"
language_version: "3.12+"
status: draft
created_at: "2026-06-18"
---

# Lesson 1: Variables and Basic Data Types

## Lesson Introduction

Welcome to the first lesson of the Python Basics course. In this lesson, we will lay the foundation
by understanding how computers store and display data.

:::info Learning Objectives After this lesson, you will be able to:

- [ ] Declare and assign values to variables confidently.
- [ ] Differentiate between Number types (int, float) and String (str).
- [ ] Accept input from the user and print the output to the screen. :::

**Prerequisites:**

- None.

**Estimated Time:** 2 hours.

---

## Part 1: Concept of Variables and Value Assignment

[Content from S01...]

---

## Part 2: Numbers and Strings

[Content from S02...]

---

## Part 3: Basic Input and Output

[Content from S03...]

---

## Lesson Recap

Summary of key points you need to remember:

1. **Variable:** Represents a memory location used to store data.
2. **Data Types:** Python has integers (`int`), floats (`float`), and strings (`str`).
3. **Built-in Functions:** Use `print()` for output and `input()` for input.

## Comprehensive Exercises

### Exercise 1: Grocery Shopping Bill (Basic)

**Requirements:** Write a program that asks the user to enter the name of a fruit, its price per kg
(float), and the quantity they want to buy (float). Calculate and print the bill according to the
format below.

**Example run:**

```text
Enter fruit name: Apple
Enter price per kg: 45000.5
Enter quantity (kg): 2.5
Bill for Apple: 112501.25 USD
```
````
`````

## Quiz

### Question 1: Which of the following is a valid variable name according to PEP 8 in Python?

- A) `User-Name`
- B) `user_name`
- C) `userName`
- D) `1_user_name`

<details>
<summary>View Answer</summary>

**Answer: B) `user_name`**

Explanation: PEP 8 recommends snake_case (lowercase words separated by underscores) for variables.
Option D is invalid because variable names cannot start with a number.

</details>
```
```
````

---

## 5. Example Task 5: Create Changelog Entry

### File `output/changelog.md` after the above tasks:

```markdown
# Changelog

All notable changes to this course will be documented in this file.

## [2026-06-18 13:55:00 +07:00]

### Created

- `output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx` — score: 8.8
  (approved)

### Reviews

- `output/reviews/sections/begin/L01_S01_review.json` — APPROVED (Score: 8.75)

---

## [2026-06-18 14:05:00 +07:00]

### Modified

- `output/sections/begin/L01_S01_concept-of-variables-and-value-assignment.mdx` — Updated
  explanation for Example 2 based on review feedback. New score: 8.9 (approved)

### Merged

- `output/lessons/begin/L01_variables-and-basic-data-types.mdx` — Merged 3 sections (S01, S02, S03).
  Status: draft.
```
