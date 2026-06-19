# Agent Instructions and Guidelines

This document provides context about the Hermes Course Generator project, its repository structure,
and rules for agents and contributors working on this codebase.

## Project Description

Hermes Course Generator is an automated toolset designed to set up, compile, and manage programming
courses (such as Rust, Python, Go) using AI Agents. It generates a standard directory structure
compatible with Docusaurus MDX and integrates directly with AI workflow templates.

Key features:

- Standardized directory structure for courses.
- CLI tool to initialize workspaces, merge lessons, and track state.
- Tailored agent templates for writing instructions, style guides, and course outlines.

## Repository Structure

- bin/ - Python source code for the CLI.
- skills/ - Global agent skill definition files.
- templates/ - Core instruction templates, workflows, and style guides.
- README.md - Main entry point with quickstart and usage guidelines.
- AGENTS.md - Agent guidelines and rules (this file).

## Guidelines and Formatting Rules

To maintain high professional standards, clarity, and consistency across all repository assets:

### Emoji Prohibition Rule

- Absolutely do not use emojis in any Markdown files (.md, .mdx) or code files.
- All headings, lists, inline texts, logs, CLI outputs, and comments must be strictly text-only,
  without graphic symbols or decorative emojis.
- Clean up any emojis encountered during edits.

### Language and Tone

- Write in a professional, clear, and concise tone.
- Document inputs, outputs, and parameters precisely.
