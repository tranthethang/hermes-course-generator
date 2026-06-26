---
name: hermes-course-validator
description: >-
  Verify all course section files for format, metadata, and headings structure, and reorder
  Docusaurus sidebar positions.
---

# Skill: Hermes Course Validator

## Overview

This skill guides the Validator Agent to perform structural checks on course sections, identify
files that violate guidelines (missing metadata or incorrect headings), and apply metadata
corrections including Docusaurus sidebar position reordering.

## Tasks and Execution

### 0. Scan Workspace Status First (Pre-flight Check)

Before starting any validation or verification, run the status check to see the overall workspace state:

```bash
hermes-course-generator status --level <level>
```

This ensures you know which sections have been generated, their draft/approved statuses, and can confirm what files need validation.

### Task 1: Verify Course Sections and Build Compilation

To run verification on all course sections in a workspace level, there are two options:

#### Option 1: Automated Verification (Recommended)

Run the CLI command with the `--build` flag:

```bash
hermes-course-generator verify --path <workspace_path> --level <level> --build
```

- `<workspace_path>`: The absolute path to the course workspace (containing the output directory).
- `<level>`: Set to "begin", "advance", "master", or "all" to check specific or all levels.
- `--build`: Runs a real Docusaurus compilation check on the files. It scaffolds a local sample
  Docusaurus website under `./sample/`, modifies the configuration (`onBrokenLinks` set to `warn`),
  symlinks the output levels, and executes `npm run build`.

If there are MDX/JSX syntax errors, the build will fail and print the compiler logs. Review these
logs, locate the files, fix the errors, and run the command again.

#### Option 2: Manual Verification Check

If the automated CLI command encounters issues, or if you want to inspect/debug the compilation in
the browser manually, perform these steps:

1. **Scaffold the Test Project:** If the `./sample/` folder does not exist, initialize it:
   ```bash
   npx -y create-docusaurus@latest sample classic --package-manager npm --javascript --skip-git
   ```
2. **Configure Docusaurus:** Edit `./sample/docusaurus.config.js` to set `onBrokenLinks: 'warn'` and
   `onBrokenMarkdownLinks: 'warn'` to prevent build failures from navbar/footer placeholder links.
3. **Clean Default Docs:** Delete all default files in `./sample/docs/*`.
4. **Copy Course Levels:** Copy the output sections levels into `./sample/docs/` (Note: Docusaurus
   does not support directory symlinks inside the docs folder):
   ```bash
   cp -R "$(pwd)/output/sections/begin" "$(pwd)/sample/docs/begin"
   cp -R "$(pwd)/output/sections/advance" "$(pwd)/sample/docs/advance"
   cp -R "$(pwd)/output/sections/master" "$(pwd)/sample/docs/master"
   ```
5. **Run Compilation Build:** Navigate to the sample directory and run the build:
   ```bash
   cd sample
   npm run build
   ```
6. **Fix and Re-run:** Capture the build logs, fix any MDX formatting errors in the source section
   files (in `output/sections/`), and run `npm run build` again. Do not delete the `./sample/`
   directory so that subsequent checks are instant.

#### Verification Criteria:

1. **Frontmatter presence:** Ensure all section files have a valid YAML frontmatter block starting
   and ending with `---`.
2. **Metadata Key/Value validation:**
   - Must contain: `id`, `title`, `sidebar_label`, `sidebar_position` (int), `level`, `lesson_id`
     (format Lxx), `lesson_title`, `section_id` (format Sxx), `section_title`, `language_version`,
     `review_score` (float), `status`.
3. **Headings validation:**
   - There must be exactly one Level-1 heading `# {Section Name}` matching `section_title`.
   - No custom Level-2 headings (`##`) are allowed.
   - All standard Level-2 headings must exist and be in the correct order depending on language
     (English vs Vietnamese).
4. **MDX Safety:** Ensure all comparison symbols, generics (e.g. `<T>`), and literal curly braces
   (`{`, `}`) in plain text are wrapped in inline code blocks or escaped.

### Task 2: Fix and Reorder Sidebar Positions

If files lack metadata or have inconsistent sidebar positions, use the CLI to automatically fix and
reorder them:

```bash
hermes-course-generator reorder --path <workspace_path> --level <level> --mode <mode>
```

- `--mode`: Can be `flat` (sets sequential sidebar_position across the entire level `1..N`) or
  `nested` (sets sequential sidebar_position within each lesson `1..6`). Use `flat` if you copy all
  section files into a single flat Docusaurus folder.
- If a section file is missing frontmatter entirely, the command automatically parses
  `architecture.md` and the file's first Level-1 heading to reconstruct the missing frontmatter and
  insert it at the top of the file.
