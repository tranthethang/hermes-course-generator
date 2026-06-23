# Task Examples

> **Target Audience:** Hermes AI Agent **Purpose:** Provide realistic examples for each type of task
> (Generate Section, Review Section, Fix Section, Merge Lesson, Generate Changelog). All code
> examples use Rust as the concrete demonstration language. When generating for a different
> language, adapt all code, references, version numbers, and style guide citations accordingly.

---

## 1. Example Task 1: Generate Section (Task: generate_section)

### User Request

```
Please generate Section S01 for Lesson L01 level "begin".
Lesson Title: "Introduction to Rust and Setup"
Section Title: "Why Rust? Key Features and Philosophy"
```

### Hermes's Realistic Response (After running workflow)

`````markdown
# Execution progress: generate_section (begin - L01_S01)

1. Read `overview.md`, `architecture.md` to get context.
2. Identified level: `begin` (learner has prior programming experience but is new to Rust).
3. Looked up The Rust Programming Language Book (Chapter 1) and the Rust Reference for key
   philosophy points (ownership, zero-cost abstractions, fearless concurrency).
4. Self-reviewed: score was 7.8. Applied 1 fix: added a concrete ownership vs. GC comparison example
   to improve Teaching Quality.
5. Re-reviewed: score 8.5. Proceeding to save.

---

### File content written: `output/sections/begin/L01_S01_why-rust-key-features-and-philosophy.mdx`

````markdown
---
id: l01_s01_why-rust-key-features-and-philosophy
title: "Why Rust? Key Features and Philosophy"
sidebar_label: "Why Rust?"
sidebar_position: 1
level: begin
lesson_id: "L01"
lesson_title: "Introduction to Rust and Setup"
section_id: "S01"
section_title: "Why Rust? Key Features and Philosophy"
language_version: "1.79.0"
review_score: 8.5
status: approved
---

# Why Rust? Key Features and Philosophy

## Introduction

Most programming languages ask you to make a trade-off: either write safe, managed code (like Java
or Python) and accept performance overhead from a garbage collector, or write fast, low-level code
(like C or C++) and risk memory bugs. Rust breaks this trade-off. It gives you memory safety and
performance simultaneously, enforced at compile time with no runtime cost.

## Prerequisites

No prerequisites. This is the starting point of the course.

## Main Concepts

Rust is built around three core guarantees:

### Memory Safety Without a Garbage Collector

Rust's ownership system tracks who owns each piece of memory. When the owner goes out of scope, Rust
automatically frees the memory. No garbage collector pauses, no manual `free()` calls, and no
dangling pointers.

### Zero-Cost Abstractions

Rust's higher-level features (iterators, closures, traits) compile down to the same machine code as
hand-written loops. You pay no runtime cost for using them.

### Fearless Concurrency

The ownership and borrowing rules that prevent memory bugs also prevent data races at compile time.
The compiler rejects programs that share mutable state unsafely across threads.

:::info Why Does This Matter? Rust's guarantees are enforced by the compiler, not by conventions or
runtime checks. This means bugs that would only appear at runtime in other languages become
compile-time errors in Rust. :::

## Code Examples

```rust
// Rust 1.79.0
// Example 1: Ownership - memory is freed automatically when the owner goes out of scope.

fn main() {
    let greeting = String::from("Hello, Rust!"); // greeting owns this String
    println!("{}", greeting);
    // greeting goes out of scope here; Rust automatically frees the memory.
    // No garbage collector needed.
}
```

```rust
// Rust 1.79.0
// Example 2: Compile-time safety - the compiler catches use-after-move errors.

fn main() {
    let name = String::from("Alice");
    let transferred = name; // ownership moves to 'transferred'

    // The line below would NOT compile:
    // println!("{}", name); // error[E0382]: borrow of moved value: `name`

    println!("{}", transferred); // This is valid; 'transferred' is the owner now.
}
```

## Common Mistakes

:::danger Common Mistake Assuming Rust works like Python or Java where variables hold references by
default. In Rust, assigning a `String` to another variable moves ownership, not copies it. :::

```rust
// INCORRECT - This does NOT compile
fn main() {
    let s1 = String::from("hello");
    let s2 = s1; // s1's ownership is moved to s2
    println!("{}", s1); // error[E0382]: borrow of moved value: `s1`
}

// CORRECT - Clone if you need both variables
fn main() {
    let s1 = String::from("hello");
    let s2 = s1.clone(); // s2 gets its own copy of the data
    println!("s1 = {}, s2 = {}", s1, s2); // Both are valid
}
```

## Best Practices

- Read error messages carefully. Rust's compiler produces some of the most helpful error messages in
  any programming language. The error code (e.g., `E0382`) links directly to detailed documentation.
- Embrace the compiler as a collaborator. When the compiler rejects your code, it is pointing out a
  real correctness issue, not being overly strict.
- Start with the ownership rules before learning about references and borrowing. Understanding
  ownership is the foundation for everything else in Rust.

:::tip Pro Tip Run `rustc --explain E0382` in your terminal to get a detailed explanation of any
Rust compiler error code directly in your shell. :::

## Mini Exercise

**Requirements:** Write a Rust program that declares a `String` variable called `language`, prints
it, then creates a clone of it called `language_copy`, and prints both. Verify that both variables
remain valid after the clone.

- Sample Input: `language = String::from("Rust")`
- Expected Output:
  ```
  language: Rust
  language_copy: Rust
  ```

## Summary

- Rust guarantees memory safety without a garbage collector through its ownership system.
- Each value in Rust has exactly one owner at any time.
- Assigning a `String` to another variable moves its ownership, invalidating the original.
- Use `.clone()` to explicitly copy heap data when you need two independent copies.
- Rust's compiler enforces these rules at compile time, turning potential runtime bugs into
  compile-time errors.

## References

- [The Rust Programming Language - Chapter 1: Getting Started](https://doc.rust-lang.org/book/ch01-00-getting-started.html)
- [The Rust Programming Language - Chapter 4: Understanding Ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
- [Rust Reference: Memory Model](https://doc.rust-lang.org/reference/memory-model.html)
````

**Self-review report:**

- Technical Accuracy: 9.0/10 (code compiles and runs, ownership semantics are correct)
- Teaching Quality: 8.5/10 (clear analogy, explains WHY before HOW)
- Example Quality: 8.5/10 (2 examples, second one demonstrates a real compile error)
- Exercise Quality: 8.0/10 (clear requirements, concrete expected output)
- Format Compliance: 9.0/10 (all required headings present, YAML complete)
- **Total weighted score: 8.7/10 (APPROVED)**
`````

---

## 2. Example Task 2: Review Section (Task: review_section)

### User Request

```
Please review: output/sections/begin/L01_S01_why-rust-key-features-and-philosophy.mdx
```

### Hermes's Realistic Response (Writes JSON review file)

```json
{
  "review_type": "section",
  "target_file": "output/sections/begin/L01_S01_why-rust-key-features-and-philosophy.mdx",
  "review_timestamp": "2026-06-18T13:52:00+07:00",
  "scores": {
    "technical_accuracy": {
      "score": 9.0,
      "weight": 0.3,
      "notes": "All code examples compile correctly under Rust 1.79.0. Ownership semantics in Example 2 are accurate. The commented-out line demonstrating the compile error is a good teaching device."
    },
    "teaching_quality": {
      "score": 8.5,
      "weight": 0.25,
      "notes": "Strong introduction with the garbage collector trade-off framing. Could improve by adding a brief analogy for 'ownership' itself before the code examples, not just after."
    },
    "example_quality": {
      "score": 8.0,
      "weight": 0.2,
      "notes": "Both examples are practical and relevant. Example 2 is excellent for showing a compile error inline. However, the clone() example in the correct section lacks a comment explaining the heap-copy cost."
    },
    "exercise_quality": {
      "score": 8.0,
      "weight": 0.15,
      "notes": "Clear requirements, concrete expected output. Exercise directly tests the clone() concept taught in this section."
    },
    "format_compliance": {
      "score": 10.0,
      "weight": 0.1,
      "notes": "All YAML fields present, all mandatory headings in correct order, no custom ## headings, code blocks have language identifiers."
    }
  },
  "total_score": 8.65,
  "result": "APPROVED",
  "strengths": [
    "The garbage collector trade-off framing in the Introduction is compelling and immediately answers 'why should I learn Rust?'",
    "Using a commented-out compile error in Example 2 is more honest than showing only working code."
  ],
  "weaknesses": [
    "The clone() example in Common Mistakes / CORRECT section does not mention the performance cost of heap allocation, which is relevant context for a language focused on performance."
  ],
  "required_fixes": [
    {
      "priority": "low",
      "location": "## Common Mistakes > CORRECT block",
      "issue": "Missing note about clone() performing a deep heap copy, which has a cost.",
      "fix": "Add comment: '// Note: clone() performs a heap allocation; prefer borrowing (&s1) when you only need to read the data.'"
    }
  ]
}
```

---

## 3. Example Task 3: Fix Section (Task: fix_section)

### User Request

```
Please fix section L01_S01 based on the JSON review file.
```

### Hermes's Realistic Response (After fixing and writing the file)

````markdown
# Execution progress: Fix section L01_S01 according to review

1. Read `output/reviews/sections/begin/L01_S01_review.json`.
2. Identified the fix: Add a comment about clone() heap allocation cost in the CORRECT block.
3. Applied the change. Re-ran self-review.

---

### Code Diff:

```diff
 // CORRECT - Clone if you need both variables
 fn main() {
     let s1 = String::from("hello");
-    let s2 = s1.clone(); // s2 gets its own copy of the data
+    let s2 = s1.clone(); // s2 gets its own copy of the data (deep heap allocation)
+    // Note: clone() has a cost. Prefer borrowing (&s1) when you only need to read the data.
     println!("s1 = {}, s2 = {}", s1, s2); // Both are valid
 }
```

---

**Re-review Report:**

- File updated successfully.
- New review score: **8.8/10** (improved Example Quality from 8.0 to 8.5).
- Status: **approved**.
- Changelog updated.
````

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
   - `L01_S01_why-rust-key-features-and-philosophy.mdx` -> APPROVED (Score: 8.8)
   - `L01_S02_setting-up-your-rust-environment.mdx` -> APPROVED (Score: 9.1)
   - `L01_S03_your-first-rust-program-hello-world.mdx` -> APPROVED (Score: 8.6)
2. Cross-section consistency check passed. Terminology is consistent across all 3 sections.
3. Ran CLI merge command successfully.
4. Filled placeholders: Introduction, Learning Objectives, Prerequisites, Time Estimate, Lesson
   Recap, Comprehensive Exercises, Quiz.

---

### File content written: `output/lessons/begin/L01_introduction-to-rust-and-setup.mdx`

```markdown
---
id: l01_introduction-to-rust-and-setup
title: "Lesson 1: Introduction to Rust and Setup"
sidebar_label: "L01: Introduction to Rust and Setup"
sidebar_position: 1
level: begin
lesson_id: "L01"
lesson_title: "Introduction to Rust and Setup"
section_count: 3
sections:
  - id: S01
    title: "Why Rust? Key Features and Philosophy"
    file: "L01_S01_why-rust-key-features-and-philosophy.mdx"
  - id: S02
    title: "Setting Up Your Rust Environment"
    file: "L01_S02_setting-up-your-rust-environment.mdx"
  - id: S03
    title: "Your First Rust Program: Hello, World!"
    file: "L01_S03_your-first-rust-program-hello-world.mdx"
language_version: "1.79.0"
status: draft
created_at: "2026-06-18"
---

# Lesson 1: Introduction to Rust and Setup

## Lesson Introduction

Welcome to the first lesson of Rust: Zero to Hero. In this lesson, we start from the ground up: why
Rust exists, how to install the toolchain, and how to write and run your first Rust program. By the
end, you will have a working Rust environment and a mental model of what makes Rust fundamentally
different from other languages.

:::info Learning Objectives

After this lesson, you will be able to:

- Explain Rust's core value proposition: memory safety without a garbage collector.
- Install Rust using `rustup` and verify your environment with `cargo`.
- Write, compile, and run a basic Rust program. :::

:::note Prerequisites

- Familiarity with at least one other programming language (any language).
- A terminal / command prompt on your operating system.
- No prior Rust experience required. :::

:::info Estimated Time: 90 minutes :::

---

## Part 1: Why Rust? Key Features and Philosophy

[Content from S01...]

---

## Part 2: Setting Up Your Rust Environment

[Content from S02...]

---

## Part 3: Your First Rust Program: Hello, World!

[Content from S03...]

---

## Lesson Recap

Key concepts from this lesson:

1. **Memory Safety**: Rust prevents memory bugs (dangling pointers, use-after-free, data races) at
   compile time through its ownership system.
2. **Ownership**: Each value has exactly one owner. When the owner goes out of scope, the value is
   freed automatically.
3. **rustup**: The official Rust toolchain installer. Use it to install and manage Rust versions.
4. **Cargo**: Rust's build system and package manager. Use `cargo new` to create projects,
   `cargo build` to compile, and `cargo run` to compile and run.
5. **Zero runtime overhead**: Rust's safety guarantees are enforced at compile time, not runtime.

## Comprehensive Exercises

### Exercise 1: Environment Verification (Basic)

**Requirements:** Using the terminal, verify your Rust installation by running the version command,
then create a new Cargo project named `hello_rust`, navigate into it, and run the default program.

- Expected output from version check: `rustc 1.79.0 (...)` (or later)
- Expected output from `cargo run`: `Hello, world!`

### Exercise 2: Ownership Experiment (Intermediate)

**Requirements:** Write a program with two functions: `print_greeting(s: String)` which takes
ownership of a String and prints it, and a `main` function that creates a String, calls
`print_greeting`, and then attempts to print the String again. Observe the compiler error,
understand why it occurs, and fix it using borrowing (`&String`).

- Expected compiler error: `error[E0382]: borrow of moved value`
- After fix with `&String` parameter: both print statements succeed.

## Quiz

### Question 1: What is Rust's primary mechanism for guaranteeing memory safety?

- A) A runtime garbage collector
- B) Manual memory management with malloc/free
- C) Compile-time ownership and borrowing rules
- D) Reference counting at runtime

<details>
<summary>View Answer</summary>

**Answer: C) Compile-time ownership and borrowing rules**

Rust enforces memory safety through its ownership system, which is checked entirely at compile time.
No garbage collector or runtime overhead is involved.

</details>

### Question 2: What does `cargo run` do?

- A) Only compiles the project without running it
- B) Compiles and then runs the project
- C) Downloads project dependencies only
- D) Runs the project without recompiling

<details>
<summary>View Answer</summary>

**Answer: B) Compiles and then runs the project**

`cargo run` is equivalent to `cargo build` followed by executing the resulting binary.

</details>
```
`````

---

## 5. Example Task 5: Create Changelog Entry

### File `output/changelog.md` after the above tasks:

```markdown
# Changelog

All notable changes to this course will be documented in this file.

## [2026-06-18 13:55:00 +07:00]

### Created

- `output/sections/begin/L01_S01_why-rust-key-features-and-philosophy.mdx` — score: 8.5 (approved, 1
  fix applied)

### Reviews

- `output/reviews/sections/begin/L01_S01_review.json` — APPROVED (Score: 8.65)

---

## [2026-06-18 14:05:00 +07:00]

### Modified

- `output/sections/begin/L01_S01_why-rust-key-features-and-philosophy.mdx` — Added clone() heap cost
  note per review feedback. New score: 8.8 (approved)

### Merged

- `output/lessons/begin/L01_introduction-to-rust-and-setup.mdx` — Merged 3 sections (S01, S02, S03).
  Status: draft. Cross-section consistency check: passed.
```

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
