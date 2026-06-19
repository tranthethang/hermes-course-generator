---
name: hermes-course-generator
description: >-
  Initialize project structure and generate syllabus and documentation for any programming course
  (Rust, C#, Java, Go, etc.) compatible with Docusaurus.
---

# Hermes Course Generator Skill

## Overview

This skill guides the Agent to interact with the user to set up an automated course creation
environment for any programming language, fully compatible with Docusaurus MDX.

## Dependencies

- CLI tool `hermes-course-generator` installed at `~/.local/bin/hermes-course-generator`.

## Quick Start

When the user requests: _"I want to create a course for [Rust/C#/Go...]"_ or _"Please set up a new
programming course"_, the Agent triggers the interactive setup workflow.

## Workflow

### Step 1: Collect Requirements (Interactive Interview)

The Agent prompts for the following parameters:

1. Target programming language
2. Target level (begin, advance, master)
3. Target audience
4. Course scope (number of Lessons & Sections)

### Step 2: Initialize Environment via CLI

The Agent runs the CLI command to generate the folder structure:
`hermes-course-generator init --path <project_path>`

### Step 3: Automatically Generate Configuration Documents (Dynamic Generation)

The Agent automatically generates 3 core personalized documents for the chosen language:

- `overview.md`: Detailed language learning objectives and outcomes.
- `architecture.md` (Syllabus): A detailed list of Lessons and Sections tailored to the language
  features.
- `style_guide.md`: Language-specific coding standards combined with MDX safety rules (e.g.,
  wrapping raw generics like `<T>` or `<string>` in inline code blocks instead of raw text).

### Step 4: Set Up State

Update the `state.md` file to list all sections and lessons with their initial state:

```yaml
status: init
completed_sections: []
```

### Step 5: Report Completion

Present the generated course structure (`architecture.md`) to the user and guide them on how to
begin the next phase of the Hermes Workflow.
