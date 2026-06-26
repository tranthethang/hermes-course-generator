# Hermes Course Generator Toolset

![Hermes Course Generator Toolset](assets/repo.png)

The **Hermes Course Generator** is an automated toolset designed to set up, compile, and manage
programming courses (e.g., Rust, Python, Go) using AI Agents. It generates a standard directory
structure compatible with Docusaurus MDX and integrates directly with AI workflow templates.

---

## Cross-Platform AI Agent Support

This toolset is **platform-agnostic** and can be used with any modern AI Coding Agent:

- **Antigravity (Native)**: Provides native integration. The agent automatically detects and
  utilizes the `SKILL.md` configurations.
- **Claude Code, Cursor, & GitHub Copilot (Codex)**: Fully supported. Since the toolset relies on
  standard Markdown files and a Python CLI, you can simply load the `SKILL.md` or template files
  into the agent's context (e.g., by mentioning `@skills/hermes-course-writer/SKILL.md`) and
  instruct the AI to adopt the described role.

---

## Quick Start

### 1. Installation

Install the CLI tool, global templates, and agent skills directly from the repository:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/install.sh | bash
```

_Note: Make sure `~/.local/bin` is in your environment `PATH` (e.g., in `~/.zshrc` or `~/.bashrc`)._

### 2. Uninstallation

To completely remove the CLI tool, global configurations, and registered skills from your system:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/uninstall.sh | bash
```

### 3. Verify Setup

Ensure all components and global configuration directories are correctly configured:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/verify.sh | bash
```

### 4. Initialize Workspace

To initialize a new course generator workspace at your current location or a specific path:

```bash
# In the current directory
hermes-course-generator init

# Or specify a custom path
hermes-course-generator init --path /path/to/new-course
```

---

## Commands & Scripts Reference

| Command / Script                                                     | Description                                                                        |
| :------------------------------------------------------------------- | :--------------------------------------------------------------------------------- |
| `hermes-course-generator init`                                       | Initializes a workspace, copying instruction templates and setting up directories. |
| `hermes-course-generator merge --level <level> --lesson <lesson_id>` | Merges individual section files (`.mdx`) into a single lesson.                     |
| `hermes-course-generator state update --key <key> --value <val>`     | Programmatically updates fields in `state.json` to track progress.                 |
| `hermes-course-generator status --level <level> [--json]`            | Displays section completion status. Use `--json` for machine-readable output.      |
| `hermes-course-generator verify [--path <path>] [--level <level>]`   | Verifies section formatting, metadata keys, and MDX safety (unescaped `<` / `>`).  |
| `hermes-course-generator reorder [--path <path>] [--level <level>]`  | Scans and sequentially reorders Docusaurus sidebar positions in section files.     |
| `hermes-course-generator evaluate --level <level> --file <file>`     | Evaluates a single section file structure and MDX safety, returning a JSON report. |
| `hermes-course-generator clear-lock`                                 | Clears the locked section in the workspace state.                                  |
| `./format.sh`                                                        | Automatically formats all Markdown and MDX files in the workspace using Prettier.  |
| `./verify_sections.sh <workspace_path> [level]`                      | Wrapper script to verify section files format and MDX safety in a workspace.       |
| `./reorder_sections.sh <workspace_path> [level] [mode]`              | Wrapper script to scan and reorder sidebar positions in a workspace.               |
| `./uninstall.sh`                                                     | Removes the CLI tool, configurations, and global skills from your system.          |

---

## Repository Structure

- [bin/](bin) — Python source code for the `hermes-course-generator` CLI.
- [skills/](skills) — Definitions of global specialized skills for AI Agents:
  - `hermes-course-setup` — Workspace setup and initial configuration.
  - `hermes-course-writer` — Detailed research and step-by-step section drafting.
  - `hermes-course-validator` — Verification of section formatting, metadata, MDX safety, and
    sidebar reordering.
  - `hermes-course-reviewer` — Quality gate review, compiler validation, and lesson merging.
  - `hermes-course-evaluator` — Independent quality grading, scoring rubric evaluation, and status
    validation.
- [templates/](templates) — Core instructional templates and style guides.
  - [hermes_workflow.md](templates/hermes_workflow.md) — The generation workflow.
  - [file_naming_convention.md](templates/file_naming_convention.md) — Slugification and output
    structure.
  - [style_guide.md](templates/style_guide.md) — Writing and styling standards.
  - [task_examples.md](templates/task_examples.md) — Examples for each AI task.
- `verify_sections.sh` — Wrapper script for running section formatting and MDX safety validation.
- `reorder_sections.sh` — Wrapper script for running Docusaurus sidebar position reordering.

---

## Triggering the AI Agent Workflow

The multi-agent workflow operates in four distinct phases.

_Note for non-autonomous/conversational agents (e.g., standard Cursor chat, ChatGPT, Copilot): If
the agent's interface cannot loop autonomously across multiple file generation steps in a single
turn, it will write or process one file at a time, report its progress, and wait. You can simply
reply with "continue" or press Enter to prompt it to proceed to the next file._

### Phase 1: Setup

Trigger the setup agent by prompting:

> "I want to set up a new course for [Rust/Python/Go]. Please use the `hermes-course-setup` skill
> and interview me to collect the required settings. Once set up, prepare the workspace for
> automated and sequential lesson generation by level [begin/advance/master]."

### Phase 2: Writing Sections

Trigger the writer agent to automatically and sequentially write all sections in a level by
prompting:

> "Please start by running `hermes-course-generator status --level [Level]` to scan the workspace
> and check if any section files have already been created or approved. Log the session resume in
> `output/changelog.md` with the count of approved and pending sections. Then, automatically and
> sequentially write all pending sections (skipping those already approved) for the level [Level]
> (begin/advance/master) using the `hermes-course-writer` skill. Generate them one by one, ensuring
> each section is written, self-reviewed, and saved successfully before moving on to the next.
>
> **Important Execution Instructions:** Do NOT stop, pause, or ask for user confirmation/interaction
> after completing each section. You must run the generation loop autonomously and sequentially.
> Only report progress and ask for review when ALL pending sections for the specified level have
> been generated, or if a critical, unrecoverable error occurs."

### Phase 3: Section Validation & Reordering

Trigger the validator agent to verify formatting, MDX safety, and sequentially reorder sidebar
positions for all files in a level by prompting:

> "Please start by running `hermes-course-generator status --level [Level]` to scan the workspace
> and identify the section files that have been created and need validation. Then, automatically and
> sequentially verify the section files for the level [Level] (begin/advance/master) and reorder
> their sidebar positions using the `hermes-course-validator` skill. Ensure all files in this level
> are processed and validated.
>
> **Important Execution Instructions:** Do NOT stop, pause, or ask for user confirmation/interaction
> after processing each file. You must validate all files in the level autonomously. Only report
> progress when ALL section files for the specified level have been validated and reordered, or if a
> critical, unrecoverable error occurs."

### Phase 2.5: Independent Evaluation (Optional)

Trigger the evaluator agent to perform independent, unbiased quality grading on generated sections
before the final review phase. This agent operates separately from the Writer and Reviewer and
cannot modify content — it only scores and records structured results.

> "Please use the `hermes-course-evaluator` skill to evaluate all section files for the level
> [Level] (begin/advance/master). For each section file, run
> `hermes-course-generator evaluate --level [Level] --file [filename]` to perform structural and MDX
> safety checks, then apply the 5-dimension scoring rubric to grade the section. Record the result
> as a JSON review file in `output/reviews/sections/[Level]/`. Do not modify any section content.
>
> **Important Execution Instructions:** Do NOT stop, pause, or ask for user confirmation/interaction
> after processing each section. Evaluate all sections in the level autonomously. Only report
> progress when ALL section files for the specified level have been evaluated, or if a critical,
> unrecoverable error occurs."

### Phase 4: Reviewing & Merging Lessons

Trigger the reviewer agent to check and merge approved sections into lessons automatically and
sequentially by prompting:

> "Please start by running `hermes-course-generator status --level [Level]` to scan the workspace
> and identify which sections are approved and lessons are pending. Then, automatically and
> sequentially review the sections and merge all lessons for the level [Level]
> (begin/advance/master) using the `hermes-course-reviewer` skill. Process each lesson one by one,
> checking all of its sections, and merging them into the final lesson files.
>
> **Important Execution Instructions:** Do NOT stop, pause, or ask for user confirmation/interaction
> after processing each lesson. You must review and merge all lessons in the level autonomously.
> Only report progress when ALL lessons for the specified level have been processed, or if a
> critical, unrecoverable error occurs."

---

## Development & Contributing

### Requirements

- Python 3.11+
- NPM (for markdownlint)
- pip (for Python dependencies)

### Setup

Create a virtual environment and install dependencies:

```bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt pytest
```

Install the CLI and skills locally:

```bash
bash install.sh
```

### Running Tests

Unit tests cover core CLI functions including `slugify`, `parse_frontmatter`, MDX safety checks, and
state JSON CRUD operations. Run them before submitting any changes to `bin/hermes-course-generator`
or to any `skills/` file:

```bash
.venv/bin/pytest tests/ -v
```

To validate that all skill files have the required YAML frontmatter fields (`name`, `description`,
`allowed-tools`):

```bash
.venv/bin/python tests/check_skills.py
```

### CI/CD

GitHub Actions runs three automated checks on every push and pull request to `main`:

- `test-cli` — installs Python dependencies, runs `pytest tests/ -v`, and verifies CLI syntax.
- `validate-skills` — checks that all `SKILL.md` files exist and have valid frontmatter.
- `lint-markdown` — runs `markdownlint-cli2` across `templates/`, `skills/`, and root Markdown
  files.

Configuration: [.github/workflows/validate.yml](.github/workflows/validate.yml)

### Workspace State Format

Starting from this version, the workspace state is stored as `state.json` (previously `state.md`).
The CLI auto-migrates existing `state.md` files to `state.json` on first run and backs up the
original as `state.md.bak`.

State schema:

```json
{
  "workspace_version": "1.0",
  "technology": "",
  "technology_version": "",
  "course_name": "",
  "course_language": "en",
  "created_at": "",
  "last_updated_at": "",
  "active_level": "",
  "active_lesson_id": "",
  "active_section_id": "",
  "locked_section": ""
}
```

To query state programmatically (machine-readable JSON output):

```bash
hermes-course-generator status --level begin --json
```
