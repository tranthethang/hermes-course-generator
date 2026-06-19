---
name: hermes-course-setup
description: >-
  Initialize the programming course workspace, conduct the interactive setup interview,
  create target directory structures, and generate initial configuration documents.
---

# Skill: Hermes Course Setup

## Overview

This skill guides the Agent to set up a new programming course generation workspace. It handles requirements gathering, directory structure creation, and initial configuration.

## Dependencies

- CLI tool `hermes-course-generator` installed at `~/.local/bin/hermes-course-generator`.

## Setup Workflow

### Step 1: Collect Course Requirements (Interactive Interview)

Ask the user for the following required parameters:
1. Target programming language (e.g., Rust, Python, Go, C#).
2. Target programming language or compiler version (e.g., Rust 2024, Python 3.12).
3. Target levels (begin, advance, master).
4. Target audience (e.g., beginners with no programming background, intermediate developers).
5. Course scope (estimated number of Lessons & Sections).

### Step 2: Initialize Workspace Directory

Run the CLI command to initialize the directory structure:
```bash
hermes-course-generator init --path <workspace_path>
```
This command:
- Generates the standard folder structure under `output/`.
- Copies course instruction templates into the workspace.
- Initializes a default `state.md` and `output/changelog.md`.

### Step 3: Generate personalized configuration files

Create the following files in the workspace root based on the target programming language:

1. **`overview.md`**: Summarizes course goals, learner outcomes, and specific targets for each level.
2. **`architecture.md`** (Syllabus): Defines the exact list of Lessons (e.g., L01, L02) and their corresponding Sections (e.g., S01, S02) with precise technical titles.
3. **`style_guide.md`**: Contains language-specific code guidelines (e.g., naming conventions, comments style) and Docusaurus MDX safety rules (e.g., wrapping generic brackets like `<T>` or `<string>` in inline code blocks).

### Step 4: Configure State

Update the initial state in `state.md` using the CLI or direct file updates to reflect the active level, lesson, and section.

### Step 5: Report Completion

Present the final workspace structure and the generated syllabus (`architecture.md`) to the user. Guide them to trigger the next phase using the `hermes-course-writer` skill.
