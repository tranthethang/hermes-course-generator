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
  1. READ goal.md (from `./goal.md` in the current working directory)
  2. READ overview.md (from `./overview.md` in the current working directory)
  3. READ architecture.md (from `./architecture.md` in the current working directory)
  4. READ style_guide.md (from `./style_guide.md` in the current working directory)
  5. READ knowledge_sources.md (from `./knowledge_sources.md` in the current working directory)
  6. READ template_section.md (from `./template_section.md` in the current working directory)
  7. READ quality_checklist.md (from `./quality_checklist.md` in the current working directory)
  8. VERIFY course_language:
       - Read course_language from state.md (from `./state.md` in the current working directory).
       - CRITICAL: The course_language value (en or vi) is the absolute source of truth. Under no circumstances should you modify course_language in state.md to match past memories, other projects, or the user's conversational language.
  9. VERIFY output directory structure:
       - Does output/sections/{level}/ exist?
       - Does output/reviews/sections/{level}/ exist?
       - If not -> CREATE directories
  10. SCAN workspace status:
       - Run command: `hermes-course-generator status --level {level}`
       - Parse the status of existing section and lesson files.
       - Log the session resume/start details to `output/changelog.md`:
         "## [YYYY-MM-DD HH:MM:SS +07:00] - Session Resumed (Level: {level}, X approved, Y pending sections)"
       - Determine and filter the list of section_ids to only include pending/unapproved sections.
  11. REPORT: "Session initialized. Ready to generate {n} sections for Lesson {lesson_id} ({level})"
```

---

## 4. Phase 2: Generate Section

```
TASK: generate_section(level, lesson_id, section_id, section_title)

PRE-CONDITION:
  - Read: template_section.md (from `./template_section.md` in the current working directory)
  - Identified: level, lesson_id, section_id

STEPS:
  1. UNDERSTAND_CONTEXT:
     - Check if this section has already been generated and approved (status: approved, score >= 8.0) during the status scan. If so, SKIP generation of this section and proceed directly to the next.
     - Read architecture.md (from `./architecture.md` in the current working directory) again to know where this section is positioned.
     - List prerequisites (what the previous section taught).

  2. RESEARCH:
     - Look up official documentation of [Language Name] for the topic
     - Note key APIs, related specifications/standards

  3. WRITE_CONTENT:
     - Apply template_section.md (from `./template_section.md` in the current working directory)
     - Apply style_guide.md (from `./style_guide.md` in the current working directory)
     - Target total section length: 500-1500 words depending on level
       (The explanation sub-section under Main Concepts: 150-400 words; remaining words
        distributed across examples, mistakes, best practices, exercise, and summary)

  4. SELF_REVIEW:
     - Calculate score according to review_instruction.md (from `./review_instruction.md` in the current working directory)
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

## 5. Detailed Retry Logic

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
  1. SCAN workspace status by running: `hermes-course-generator status --level {level}`
  2. Check YAML frontmatter of each file matching the lesson prefix:
     - status == "approved"?
     - review_score >= 8.0?
  3. Compare with the section_ids list from architecture.md
  4. CROSS-SECTION CONSISTENCY CHECK:
     - Read all approved section files for this lesson.
     - Verify terminology is consistent across sections (same term used for the same concept).
     - Verify no concept is used in a later section that was not introduced in an earlier section.
     - Verify code style is consistent (e.g., type annotation style, naming conventions are uniform).
     - If an inconsistency is found: NOTE it in the report and flag the affected section(s) for
       a targeted fix before merging.

REPORT:
  Ready sections: [S01, S02, S03]
  Missing sections: [S04]
  Not approved: [S05 (score: 7.5)]
  Consistency issues: [S02 uses 'binding' where S01 used 'variable' for the same concept]

IF all sections are ready AND no consistency blockers:
  -> PROCEED to merge_lesson
ELSE:
  -> REPORT missing/not-approved sections and consistency issues
  -> STOP (wait to resolve before merging)
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
  2. Activate Reviewer Persona (see review_instruction.md Section 0)
  3. Review according to review_instruction.md (Lesson Review section)
  4. Calculate overall score
  5. Export review result
  6. Save: output/reviews/lessons/{level}/{lesson_id}_review.json

  IF score >= 8.0:
    -> Update lesson status: reviewed
    -> REPORT: "Lesson ready for publish"
  ELSE:
    -> REPORT weaknesses and required_fixes
    -> STOP (wait for fixing each issue)
```

---

## 8. Phase 6: Course Completion Verification

```
TASK: verify_course_complete

TRIGGER: Run after the last lesson of the last level is reviewed.

STEPS:
  1. VERIFY all lessons in architecture.md have a corresponding file in output/lessons/{level}/.
  2. VERIFY all lesson files have status: reviewed.
  3. CHECK for any remaining sections with status: needs-revision and report them.
  4. RUN format.sh (if available) to format all output files consistently.
  5. GENERATE output/COURSE_SUMMARY.md with:
       - Course name and version
       - Total lessons per level (begin / advance / master)
       - Total sections across the course
       - Average section review score
       - Generation date range (first changelog entry to last)
       - List of any sections that required more than 1 fix attempt
  6. REPORT: "Course complete. All lessons reviewed. Ready for Docusaurus integration."

OUTPUT:
  - output/COURSE_SUMMARY.md
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
