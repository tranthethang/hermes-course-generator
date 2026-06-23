# Hermes Workflow

> **Target Audience:** Hermes AI Agent  
> **Purpose:** Full workflow from section generation to lesson merging, including retry logic and
> changelog rules.

---

## 1. Workflow Overview

```mermaid
flowchart TD
    Start([START]) --> ResearchSyllabus[RESEARCH SYLLABUS<br/>Search course roadmaps & design architecture]
    ResearchSyllabus --> UserApprove{user approved?}
    UserApprove -- Yes --> ReadInstr[READ INSTRUCTIONS<br/>Mandatory: read all instruction files]
    UserApprove -- No --> ResearchSyllabus
    ReadInstr --> GetParams[GET TASK PARAMS<br/>Identify: level, lesson_id, section_id]

    subgraph SectionGenLoop [Section Generation Loop (repeat for each section)]
        GetParams --> GenSection[GENERATE SECTION]
        GenSection --> SelfReview[SELF REVIEW]
        SelfReview --> PassSection{pass?}
        PassSection -- Yes --> SaveSection[SAVE SECTION]
        PassSection -- No --> GenSection
    end

    SaveSection --> CheckReady[CHECK ALL SECTIONS READY]

    CheckReady --> AllApproved{all approved?}
    AllApproved -- Yes --> MergeLesson[MERGE LESSON]
    AllApproved -- No --> GetParams

    MergeLesson --> ReviewLesson[REVIEW LESSON]
    ReviewLesson --> PassLesson{pass?}
    PassLesson -- Yes --> SaveLesson[SAVE LESSON]
    PassLesson -- No --> MergeLesson

    SaveLesson --> UpdateChangelog[UPDATE CHANGELOG]
    UpdateChangelog --> End([END])
```

---

## 2. Phase 0: Market Research & Syllabus Benchmarking

```
TASK: research_and_design_syllabus

INPUT:
  - target_language: [Language/Technology name]
  - target_audience: [Target Audience description]

STEPS:
  1. SEARCH online course platforms (Coursera, Udemy, edX, Google Comprehensive Rust, etc.) for existing syllabi and roadmaps of the target language.
  2. IDENTIFY key concepts, IDE tools, best practices, and popular project/exercise ideas from top-tier sources.
  3. CREATE a roadmap_benchmark.md document summarizing:
       - Top 3 benchmarked courses and their key modules.
       - Recommended tools (e.g., rust-analyzer, formatters, debuggers) to include.
       - Suggested changes or enhancements to standard curricula.
  4. DESIGN or UPDATE the architecture.md file using the benchmark insights to ensure a comprehensive, modern, and competitive curriculum.
  5. PRESENT the architecture.md and roadmap_benchmark.md to the user and obtain explicit approval before proceeding to Phase 1.

OUTPUT:
  - roadmap_benchmark.md
  - architecture.md
```

---

## 3. Phase 1: Initialization

```
TASK: init_session

INPUT:
  - level: begin | advance | master
  - lesson_id: L01..LNN
  - section_ids: [S01, S02, S03, ...]  # List of sections to create

STEPS:
  1. READ goal.md
  2. READ overview.md
  3. READ architecture.md
  4. READ style_guide.md
  5. READ knowledge_sources.md
  6. READ template_section.md
  7. READ quality_checklist.md
  8. VERIFY output directory structure:
       - Does output/sections/{level}/ exist?
       - Does output/reviews/sections/{level}/ exist?
       - If not → CREATE directories
  9. REPORT: "Session initialized. Ready to generate {n} sections for Lesson {lesson_id} ({level})"
```

---

## 4. Phase 2: Generate Section

```
TASK: generate_section(level, lesson_id, section_id, section_title)

PRE-CONDITION:
  - Read: template_section.md
  - Identified: level, lesson_id, section_id

STEPS:
  1. UNDERSTAND_CONTEXT:
     - Read architecture.md again to know where this section is positioned
     - List prerequisites (what the previous section taught)

  2. RESEARCH:
     - Look up official documentation of [Language Name] for the topic
     - Note key APIs, related specifications/standards

  3. WRITE_CONTENT:
     - Apply template_section.md
     - Apply style_guide.md
     - Target: 500–1500 words depending on level

  4. SELF_REVIEW:
     - Calculate score according to review_instruction.md
     - Export JSON review result

  5. DECISION:
     IF score >= 8.0:
       → GO TO save_section
     ELIF score >= 6.0:
       → APPLY required_fixes
       → RE_REVIEW (max 2 times)
       IF after 2 times still < 8.0:
         → REPORT "Needs support: score {score} after 2 fixes"
         → STOP (wait for user instruction)
     ELSE (score < 6.0):
       → DISCARD current content
       → REWRITE from scratch (only once)
       → RE_REVIEW
       IF still < 8.0:
         → REPORT "Cannot achieve score >= 8.0. Topic needs re-evaluation."
         → STOP

  6. SAVE_SECTION:
     - Populate review_score and status: approved in frontmatter
     - Save: output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
     - Save review: output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
     - Run: hermes-course-generator state update --key "active_section_id" --value "{lesson_id}_{section_id}"

  7. REPORT:
     Section saved: [file path]
     Score: {score}/10
     Status: approved

OUTPUT:
  - output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
  - output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
```

---

## 4. Detailed Retry Logic

```
FUNCTION retry_section(section_content, review_result, attempt_number):

  IF attempt_number > 2:
    RAISE "Max retry exceeded"
    RETURN False

  weaknesses = review_result["weaknesses"]
  required_fixes = review_result["required_fixes"]

  FOR each fix IN required_fixes:
    APPLY fix to section_content

  new_review = self_review(section_content)
  new_score = new_review["total_score"]

  IF new_score >= 8.0:
    RETURN (section_content, new_review)
  ELSE:
    RETURN retry_section(section_content, new_review, attempt_number + 1)
```

Retry limits:

- `generate_section`: 2 fixes, 1 rewrite
- `merge_lesson`: 1 fix if quality check fails
- No infinite loop

---

## 5. Phase 3: Check Sections Readiness

```
TASK: check_sections_ready(level, lesson_id)

STEPS:
  1. List all files in output/sections/{level}/ with prefix {lesson_id}_
  2. Check YAML frontmatter of each file:
     - status == "approved"?
     - review_score >= 8.0?
  3. Compare with the section_ids list from architecture.md

REPORT:
  Ready sections: [S01, S02, S03]
  Missing sections: [S04]
  Not approved: [S05 (score: 7.5)]

IF all sections are ready:
  → PROCEED to merge_lesson
ELSE:
  → REPORT missing/not-approved sections
  → STOP (wait to generate missing sections)
```

---

## 6. Phase 4: Merge Lesson

```
TASK: merge_lesson(level, lesson_id)

PRE-CONDITION:
  - check_sections_ready() passed

STEPS:
  1. CLI_MERGE:
     - Run command: `hermes-course-generator merge --level {level} --lesson {lesson_id}`
     - This command automatically merges sections, removes redundant metadata, and creates a new `.mdx` file containing `{/* HERMES:FILL ... */}` placeholders.

  2. FILL_CONTENT:
     - Open the newly created `.mdx` file.
     - Replace the `{/* HERMES:FILL ... */}` lines with content generated by the Agent (Intro, Recap, Exercises, Quiz).
     - DO NOT modify code blocks or text copied from the sections.

  3. QUALITY_CHECK:
     - Run Checklist 2 in quality_checklist.md
     IF any REQUIRED item fails:
       → FIX the issue

  4. SAVE_LESSON:
     - Save the filled `.mdx` file.
     - Update state: `hermes-course-generator state update --key "active_lesson_id" --value "{lesson_id}"`

  5. REPORT:
     Lesson merged and filled: [file path]
     Status: draft (waiting for review)

OUTPUT:
  - output/lessons/{level}/{lesson_id}_{slug}.mdx
```

---

## 7. Phase 5: Review Lesson

```
TASK: review_lesson(level, lesson_id)

STEPS:
  1. Load lesson file
  2. Review according to review_instruction.md (Lesson Review section)
  3. Calculate overall score
  4. Export review result
  5. Save: output/reviews/lessons/{level}/{lesson_id}_review.json

  IF score >= 8.0:
    → Update lesson status: reviewed
    → REPORT: "Lesson ready for publish"
  ELSE:
    → REPORT weaknesses and required_fixes
    → STOP (wait for fixing each issue)
```

---

## 8. Changelog Rules

Each time a file is created, modified, or merged, Hermes must update `output/changelog.md`:

```markdown
## [YYYY-MM-DD HH:MM +07:00]

### Created

- `output/sections/begin/L01_S01_bien-va-gia-tri.mdx` — score: 8.5

### Modified

- `output/sections/begin/L01_S02_kieu-du-lieu.mdx` — score: 7.0 → 8.2 (applied 2 fixes)

### Merged

- `output/lessons/begin/L01_bien-va-kieu-du-lieu.mdx` — 4 sections merged

### Reviews

- `output/reviews/sections/begin/L01_S01_review.json` — APPROVED
```

**Changelog rules:**

- Each entry must have a full timestamp.
- Do not delete old entries.
- Note scores before and after modifications.
- Note the number of retries if any.

---

## 9. Error Handling

```
ERROR: File not found
  → Check path according to file_naming_convention.md
  → Check if output directories have been created
  → REPORT specific error and the path to check

ERROR: Score not achieved after 2 retries
  → SAVE draft with status: "needs-revision"
  → Clearly list required_fixes in the file
  → REPORT to user for decision

ERROR: Missing section during merge
  → STOP merge
  → LIST missing sections
  → REQUEST: "Need to generate sections: [list]"

ERROR: Template does not exist
  → STOP
  → REPORT: "Cannot find template_section.md or template_lesson.md"
  → REQUEST: "Please create template files first"

ERROR: API rate limit (HTTP 429) or quota exceeded
  → DO NOT stop execution
  → APPLY exponential backoff with random jitter (e.g. wait 5s + jitter, then 10s, 20s, up to 60s max)
  → RETRY up to 5 times
  → IF all 5 retries fail, print warning, wait 120s, and attempt one final retry before prompting user

ERROR: Transient API/network error (500, 502, 503, 504)
  → RETRY after 3 seconds
  → Attempt up to 3 retries
  → IF failure persists, save progress, update state, and prompt user
```

---

## 10. File Status Lifecycle

```
draft → reviewed → approved → published
  │          │           │
  │          │           └── Only set when score >= 8.0
  │          └── After passing review_instruction.md
  └── Right after generating content
```

Additional: `needs-revision` — used when score < 8.0 after max retry.
