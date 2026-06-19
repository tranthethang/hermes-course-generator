# Course Generation Goal

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Define execution goals, autonomous behavior rules, and API error resilience
> guidelines.

---

## 1. Primary Objectives

The primary goal of this execution is to fully generate a high-quality programming course that is
structured, correct, and compatible with Docusaurus MDX, following the instructions and schemas
defined in the workspace.

Specific responsibilities:

- Automatically identify the active level, lesson, and sections from `state.md` and
  `architecture.md`.
- Generate, self-review, and refine all sections for the active lesson one-by-one.
- Merge approved sections into a single complete lesson file using the CLI tool.
- Fill out the lesson templates, verify quality against checklists, and update the state.
- Keep the changelog up-to-date with complete details.

---

## 2. Autonomous Execution Rules

To prevent stopping and asking the user for confirmation repeatedly, Hermes must run under the
following autonomous rules:

- **Automatic Decisions:** Use the review score calculated in `review_instruction.md` to make
  decisions (approve, fix, or rewrite) automatically without checking with the user first.
- **Pre-emptive File Creation:** Directly write generated/reviewed files to the output directories
  without asking for permission to create or modify files.
- **State Progression:** When a task is completed (e.g., all sections for a lesson are approved),
  automatically proceed to the next step (e.g., merging the lesson, filling out placeholders)
  without pausing.
- **Silence Prompts:** Avoid asking clarifying questions unless a critical block is encountered that
  cannot be resolved automatically (e.g., conflicting architecture specifications).

---

## 3. Resilient API Error Handling

When calling LLM or other external APIs, Hermes is highly likely to encounter transient errors, rate
limits, or quota limits. Hermes must handle these issues gracefully to prevent execution from
stopping.

### 3.1 Handling HTTP 429 (Too Many Requests / Rate Limit)

When an API call fails with HTTP 429 or quota limit errors:

- Do not crash or stop execution.
- Implement Exponential Backoff with Jitter:
  1. Wait for an initial delay of 5 seconds.
  2. Retry the API call.
  3. If it fails again, double the wait time (e.g., 10 seconds, then 20 seconds, up to a maximum of
     60 seconds).
  4. Add a small random jitter (e.g., 1-3 seconds) to the wait time to avoid synchronized retries.
- Retry Limits: Attempt the API call up to 5 times.
- User Notification: If all 5 retries fail, print a warning log, wait for 120 seconds, and try one
  more time before pausing to ask the user.

### 3.2 Handling General API Failures (500, 502, 503, 504)

For server errors or connection timeouts:

- Retry after a 3-second delay.
- Attempt up to 3 retries.
- If the error persists, save the current progress in the workspace, record the state, and then
  prompt the user.

---

## 4. Success Criteria

The execution is considered successful when:

1. All sections for the active lesson are generated and have a review score of 8.0 or higher.
2. The lesson is merged, fully filled, and passes the quality checklist.
3. The `state.md` and `output/changelog.md` are updated to reflect the successful generation.
