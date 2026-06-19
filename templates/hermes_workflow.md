# Hermes Workflow

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Workflow đầy đủ từ generate section đến merge lesson, bao gồm retry logic và
> changelog rules.

---

## 1. Tổng Quan Workflow

```
[START]
    │
    ▼
[READ INSTRUCTIONS]  ← Bắt buộc: đọc tất cả file instruction
    │
    ▼
[GET TASK PARAMS]    ← Xác định: level, lesson_id, section_id
    │
    ├──► [GENERATE SECTION] ──► [SELF REVIEW] ──► pass? ──► [SAVE SECTION]
    │         (repeat for each section)                           │
    │                                                             │
    ▼                                                             ▼
[CHECK ALL SECTIONS READY] ──► all approved? ──► [MERGE LESSON]
    │
    ▼
[REVIEW LESSON] ──► pass? ──► [SAVE LESSON]
    │
    ▼
[UPDATE CHANGELOG]
    │
    ▼
[END]
```

---

## 2. Phase 1: Khởi Động (Initialization)

```
TASK: init_session

INPUT:
  - level: begin | advance | master
  - lesson_id: L01..LNN
  - section_ids: [S01, S02, S03, ...]  # Danh sách section cần tạo

STEPS:
  1. READ overview.md
  2. READ architecture.md
  3. READ style_guide.md
  4. READ knowledge_sources.md
  5. READ template_section.md
  6. READ quality_checklist.md
  7. VERIFY output directory structure:
       - output/sections/{level}/ → tồn tại?
       - output/reviews/sections/{level}/ → tồn tại?
       - Nếu không → CREATE directories
  8. REPORT: "Session initialized. Ready to generate {n} sections for Lesson {lesson_id} ({level})"
```

---

## 3. Phase 2: Generate Section

```
TASK: generate_section(level, lesson_id, section_id, section_title)

PRE-CONDITION:
  - Đã đọc: template_section.md
  - Đã xác định: level, lesson_id, section_id

STEPS:
  1. UNDERSTAND_CONTEXT:
     - Đọc lại architecture.md để biết section này nằm ở đâu
     - Liệt kê prerequisites (section trước đã dạy gì)

  2. RESEARCH:
     - Tra cứu tài liệu chính thức của [Tên Ngôn Ngữ] cho topic
     - Ghi chú các API chính, đặc tả/chuẩn liên quan

  3. WRITE_CONTENT:
     - Áp dụng template_section.md
     - Áp dụng style_guide.md
     - Target: 500–1500 từ tùy level

  4. SELF_REVIEW:
     - Tính score theo review_instruction.md
     - Xuất JSON review result

  5. DECISION:
     IF score >= 8.0:
       → GO TO save_section
     ELIF score >= 6.0:
       → APPLY required_fixes
       → RE_REVIEW (max 2 lần)
       IF sau 2 lần vẫn < 8.0:
         → REPORT "Cần hỗ trợ: score {score} sau 2 lần sửa"
         → STOP (chờ instruction từ người dùng)
     ELSE (score < 6.0):
       → DISCARD current content
       → REWRITE from scratch (1 lần duy nhất)
       → RE_REVIEW
       IF vẫn < 8.0:
         → REPORT "Không thể đạt score >= 8.0. Cần xem xét lại topic."
         → STOP

  6. SAVE_SECTION:
     - Điền review_score và status: approved vào frontmatter
     - Lưu: output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
     - Lưu review: output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
     - Chạy `hermes-course-generator state update --key "active_section_id" --value "{lesson_id}_{section_id}"`

  7. REPORT:
     ✅ Section saved: [file path]
     📊 Score: {score}/10
     📌 Status: approved

OUTPUT:
  - output/sections/{level}/{lesson_id}_{section_id}_{slug}.mdx
  - output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
```

---

## 4. Retry Logic Chi Tiết

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

Giới hạn retry:

- `generate_section`: 2 lần sửa, 1 lần viết lại
- `merge_lesson`: 1 lần sửa nếu quality check fail
- Không có infinite loop

---

## 5. Phase 3: Kiểm Tra Đủ Sections

```
TASK: check_sections_ready(level, lesson_id)

STEPS:
  1. Liệt kê tất cả file trong output/sections/{level}/ có prefix {lesson_id}_
  2. Kiểm tra YAML frontmatter của từng file:
     - status == "approved" ?
     - review_score >= 8.0 ?
  3. Đối chiếu với danh sách section_ids từ architecture.md

REPORT:
  ✅ Ready sections: [S01, S02, S03]
  ❌ Missing sections: [S04]
  ⚠️  Not approved: [S05 (score: 7.5)]

IF tất cả sections đều ready:
  → PROCEED to merge_lesson
ELSE:
  → REPORT missing/not-approved sections
  → STOP (chờ generate missing sections)
```

---

## 6. Phase 4: Merge Lesson

```
TASK: merge_lesson(level, lesson_id)

PRE-CONDITION:
  - check_sections_ready() đã pass

STEPS:
  1. CLI_MERGE:
     - Chạy command: `hermes-course-generator merge --level {level} --lesson {lesson_id}`
     - Command này tự động nối các section lại, bỏ đi metadata thừa, và tạo file `.mdx` mới chứa các dòng `<!-- HERMES:FILL ... -->`

  2. FILL_CONTENT:
     - Mở file `.mdx` vừa được tạo ra.
     - Thay thế các dòng `<!-- HERMES:FILL ... -->` bằng nội dung do bạn tự sinh ra (Intro, Recap, Exercises, Quiz).
     - KHÔNG ĐƯỢC CHỈNH SỬA các đoạn văn bản code từ section đã được copy vào.

  3. QUALITY_CHECK:
     - Chạy Checklist 2 trong quality_checklist.md
     IF any REQUIRED item fails:
       → FIX the issue

  4. SAVE_LESSON:
     - Lưu lại file `.mdx` sau khi điền.
     - Update trạng thái: `hermes-course-generator state update --key "active_lesson_id" --value "{lesson_id}"`

  5. REPORT:
     ✅ Lesson merged và filled: [file path]
     📌 Status: draft (chờ review)

OUTPUT:
  - output/lessons/{level}/{lesson_id}_{slug}.mdx
```

---

## 7. Phase 5: Review Lesson

```
TASK: review_lesson(level, lesson_id)

STEPS:
  1. Load lesson file
  2. Review theo review_instruction.md (phần Lesson Review)
  3. Tính score tổng hợp
  4. Xuất review result
  5. Lưu: output/reviews/lessons/{level}/{lesson_id}_review.json

  IF score >= 8.0:
    → Cập nhật lesson status: reviewed
    → REPORT: "Lesson ready for publish"
  ELSE:
    → REPORT weaknesses và required_fixes
    → STOP (chờ fix từng issue)
```

---

## 8. Changelog Rules

Mỗi khi tạo, sửa, hoặc merge file, Hermes phải cập nhật `output/changelog.md`:

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

**Quy tắc changelog:**

- Mỗi entry phải có timestamp đầy đủ.
- Không xóa entry cũ.
- Ghi chú score trước và sau khi sửa.
- Ghi chú số lần retry nếu có.

---

## 9. Error Handling

```
ERROR: File not found
  → Kiểm tra lại đường dẫn theo file_naming_convention.md
  → Kiểm tra xem output directories đã tạo chưa
  → REPORT lỗi cụ thể và đường dẫn cần kiểm tra

ERROR: Score không đạt sau 2 lần retry
  → SAVE draft với status: "needs-revision"
  → Ghi rõ danh sách required_fixes vào file
  → REPORT cho người dùng để quyết định

ERROR: Missing section khi merge
  → STOP merge
  → LIST missing sections
  → REQUEST: "Cần generate các section: [danh sách]"

ERROR: Template không tồn tại
  → STOP
  → REPORT: "Không tìm thấy template_section.md hoặc template_lesson.md"
  → REQUEST: "Vui lòng tạo file template trước"
```

---

## 10. Trạng Thái File (Status Lifecycle)

```
draft → reviewed → approved → published
  │          │           │
  │          │           └── Chỉ set khi score >= 8.0
  │          └── Sau khi qua review_instruction.md
  └── Ngay sau khi tạo xong nội dung
```

Thêm: `needs-revision` — dùng khi score < 8.0 sau max retry.
