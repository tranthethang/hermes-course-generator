# Lesson Merge Instruction

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Hướng dẫn quy trình merge nhiều section thành một lesson hoàn chỉnh.

---

## 1. Điều Kiện Tiên Quyết

Hermes KHÔNG được bắt đầu merge nếu chưa đủ điều kiện:

- [ ] Tất cả các section cho lesson đó đã có file trong `output/sections/{level}/`
- [ ] Tất cả section có `status: approved` trong YAML frontmatter
- [ ] Tất cả section có `review_score >= 8.0`
- [ ] Đã đọc `template_lesson.md`
- [ ] Đã xác định đúng `level`, `lesson_id`, `lesson_title`

Nếu bất kỳ section nào chưa pass review → **DỪNG LẠI**, hoàn thiện section đó trước.

---

## 2. Input Cần Chuẩn Bị

```
1. template_lesson.md                      → Cấu trúc lesson bắt buộc
2. output/sections/{level}/{lesson_id}_*.md → Tất cả section của lesson
3. overview.md                              → Kiểm tra mục tiêu lesson
4. architecture.md                          → Xác nhận thứ tự section đúng
```

---

## 3. Quy Trình Merge (6 Bước)

### Bước 1: Đọc và Liệt Kê Sections

Liệt kê tất cả section files của lesson theo thứ tự `section_id`:

```
Lesson L02 - Advance - "Hàm và Closures":
  1. L02_S01_ham-co-ban.md              (score: 9.0, status: approved)
  2. L02_S02_arguments-va-return.md     (score: 8.5, status: approved)
  3. L02_S03_closures.md                (score: 8.0, status: approved)
  4. L02_S04_decorator-co-ban.md        (score: 9.5, status: approved)
```

Nếu `section_id` không liên tiếp (ví dụ S01, S03 mà thiếu S02) → **DỪNG LẠI** và báo cáo.

### Bước 2: Giữ Đúng Thứ Tự Section

- Merge theo thứ tự `section_id` tăng dần: S01 → S02 → S03...
- KHÔNG đảo thứ tự dù nội dung có vẻ logic hơn.
- Nếu cần thay đổi thứ tự → phải cập nhật `architecture.md` trước.

### Bước 3: Loại Bỏ Trùng Lặp

Khi ghép các section, kiểm tra và xử lý:

| Loại trùng lặp                            | Xử lý                                                             |
| ----------------------------------------- | ----------------------------------------------------------------- |
| Cùng một ví dụ code xuất hiện ở 2 section | Giữ ví dụ ở section phù hợp nhất, xóa ở section còn lại           |
| Cùng một giải thích khái niệm             | Giữ giải thích đầy đủ nhất, rút gọn phần còn lại thành tham chiếu |
| Cùng một lỗi thường gặp được đề cập       | Hợp nhất vào một chỗ                                              |
| Best practice xuất hiện ở nhiều section   | Chuyển vào phần "Best Practices" tổng hợp của lesson              |

**KHÔNG được xóa ví dụ code nếu nó minh họa một khía cạnh khác nhau**, dù cùng chủ đề.

### Bước 4: Thêm Nội Dung Lesson-Level

Sau khi merge các section, thêm các phần sau:

#### 4.1 Lesson Introduction (Giới Thiệu Lesson)

- Tổng quan về chủ đề của lesson (100–200 từ).
- Mục tiêu học tập: "Sau lesson này, bạn sẽ biết/có thể..."
- Yêu cầu kiến thức trước (prerequisites).
- Thời gian ước tính học.

```markdown
## Giới Thiệu Lesson

:::info Mục Tiêu Học Tập
Sau bài học này, bạn sẽ có thể:

- [ ] [Mục tiêu 1]
- [ ] [Mục tiêu 2]
- [ ] [Mục tiêu 3]
      :::

**Yêu cầu trước:**

- [Kiến thức cần có]

**Thời gian ước tính:** X giờ
```

#### 4.2 Lesson Recap (Ôn Tập)

- Tóm tắt toàn bộ lesson thành 5–8 bullet points.
- Không lặp lại nguyên văn từ các section.
- Nhấn mạnh các điểm kết nối giữa các section.

```markdown
## Ôn Tập Lesson

Trong lesson này, chúng ta đã học:

- **[Khái niệm 1]:** [Tóm tắt 1 câu]
- **[Khái niệm 2]:** [Tóm tắt 1 câu]
  ...
```

#### 4.3 Lesson Exercises (Bài Tập Tổng Hợp)

- 2–3 bài tập tổng hợp kiến thức NHIỀU section.
- Mỗi bài tập có: tiêu đề, mô tả, requirements, input/output mẫu.
- Phân mức độ: cơ bản → nâng cao.

```markdown
## Bài Tập Tổng Hợp

### Bài 1: [Tên bài] (Cơ bản)

**Mô tả:** ...
**Yêu cầu:** ...
**Input mẫu:** ...
**Output mong đợi:** ...

### Bài 2: [Tên bài] (Nâng cao)

...
```

#### 4.4 Lesson Quiz

- 5 câu hỏi trắc nghiệm, mỗi câu 4 đáp án.
- Phân bố: 2 câu lý thuyết, 2 câu đọc code, 1 câu debug.
- Đáp án đúng đặt trong `<details>` tag (hidden by default).

```markdown
## Quiz

### Câu 1: [Câu hỏi?]

- A) [Đáp án A]
- B) [Đáp án B]
- C) [Đáp án C]
- D) [Đáp án D]

<details>
<summary>Xem đáp án</summary>
**Đáp án: B** – [Giải thích ngắn]
</details>
```

### Bước 5: Kiểm Tra Lesson Hoàn Chỉnh

Sau khi merge, chạy checklist trong `quality_checklist.md` phần "Checklist trước khi merge lesson".

Đặc biệt kiểm tra:

- Tính liên kết (flow): section 1 → section 2 → ... có mạch lạc không?
- Độ phức tạp tăng dần: section đầu đơn giản hơn section cuối?
- Terminologi nhất quán: cùng một khái niệm dùng cùng một từ?

### Bước 6: Lưu Lesson

Lưu vào:

```
output/lessons/{level}/{lesson_id}_{slug}.md
```

Ví dụ:

```
output/lessons/begin/L01_bien-va-kieu-du-lieu.md
output/lessons/advance/L02_ham-va-closures.md
output/lessons/master/L04_tieu-de-lesson.md
```

---

## 4. Quy Tắc Dùng `template_lesson.md`

- Đọc toàn bộ `template_lesson.md` trước khi bắt đầu merge.
- Sử dụng đúng cấu trúc heading từ template.
- Điền đầy đủ YAML frontmatter của lesson.
- Cập nhật `section_count` và danh sách `sections`.

YAML frontmatter bắt buộc cho lesson:

```yaml
---
id: l01_slug # Định dạng: l<lesson_id_lower>_<slug>
title: "Tên Lesson"
sidebar_label: "Tên Lesson"
sidebar_position: 1 # Thứ tự hiển thị của lesson
level: begin | advance | master
lesson_id: "L01"
lesson_title: "Tên Lesson"
section_count: 4
sections:
  - id: S01
    title: "Tên Section 1"
    file: "L01_S01_slug.md"
  - id: S02
    title: "Tên Section 2"
    file: "L01_S02_slug.md"
language_version: "1.0.0" # Phiên bản ngôn ngữ
status: draft | reviewed | published
created_at: "YYYY-MM-DD"
---
```

---

## 5. Những Điều KHÔNG Được Làm Khi Merge

- ❌ KHÔNG viết lại nội dung tốt đã có sẵn trong section.
- ❌ KHÔNG xóa ví dụ code hữu ích dù có vẻ trùng lặp.
- ❌ KHÔNG thay đổi ý nghĩa của code ví dụ khi chỉnh sửa.
- ❌ KHÔNG thêm nội dung hoàn toàn mới vào lesson khi merge (phải tạo section mới).
- ❌ KHÔNG merge khi còn section chưa được approved.

---

## 6. Output Báo Cáo Sau Merge

```
✅ Lesson đã merge: output/lessons/advance/L02_ham-va-closures.md
📦 Sections đã merge:
   - L02_S01_ham-co-ban.md (score: 9.0)
   - L02_S02_arguments-va-return.md (score: 8.5)
   - L02_S03_closures.md (score: 8.0)
   - L02_S04_decorator-co-ban.md (score: 9.5)
🔄 Trùng lặp đã xử lý: 2 đoạn
➕ Nội dung đã thêm: Introduction, Recap, 2 Exercises, 5 Quiz questions
📌 Lesson status: draft (cần review tổng thể trước khi published)
```
