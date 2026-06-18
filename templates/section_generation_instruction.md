# Section Generation Instruction

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Hướng dẫn chi tiết quy trình tạo **một** section duy nhất cho khóa học [Tên Ngôn Ngữ].

---

## 1. Nguyên Tắc Cốt Lõi

- **Tạo đơn lẻ:** Hermes chỉ tạo **MỘT** section trong mỗi task. Không bao giờ tạo nhiều section cùng lúc.
- **Tương thích Docusaurus:** Toàn bộ nội dung Markdown sinh ra phải tương thích với Docusaurus MDX.
- **MDX Safety (Cực kỳ quan trọng):** Tuyệt đối KHÔNG viết các ký tự so sánh hoặc tag giả trần trụi trong văn bản (ví dụ: `<T>`, `<string>`, `<int>`). Parser MDX của Docusaurus sẽ hiểu nhầm đây là tag JSX/HTML và báo lỗi compile. Phải viết các chuỗi này bên trong cặp backticks (ví dụ: `` `<T>` ``) hoặc escape các ký tự `<` và `>`.
- **Hộp ghi chú (Admonitions):** Sử dụng cú pháp Docusaurus Admonitions (`:::note`, `:::tip`, `:::info`, `:::warning`, `:::danger`) thay vì cú pháp Github-style (`> [!NOTE]`).

---

## 2. Input Cần Đọc Trước Khi Bắt Đầu

Hermes PHẢI đọc đầy đủ các file sau **theo thứ tự**:

```
1. overview.md              → Hiểu mục tiêu tổng thể và audience
2. architecture.md          → Hiểu lesson hiện tại thuộc đâu trong toàn khóa
3. template_section.md      → Xem cấu trúc section bắt buộc phải theo
4. style_guide.md           → Áp dụng quy tắc văn phong
5. knowledge_sources.md     → Biết nguồn nào được phép tham khảo
6. quality_checklist.md     → Biết tiêu chí trước khi lưu
```

---

## 3. Metadata Bắt Buộc Trước Khi Tạo Section

Trước khi viết bất kỳ nội dung nào, Hermes phải xác định rõ:

```yaml
id: l01_s01_slug # Định dạng: l<lesson_id_lower>_s<section_id_lower>_<slug>
title: "Tên section"
sidebar_label: "Tên section"
sidebar_position: 1 # Số thứ tự hiển thị trong lesson
level: begin | advance | master
lesson_id: "L01" # Ví dụ: L01, L02, L03
lesson_title: "Tên lesson" # Ví dụ: "Biến và Kiểu Dữ Liệu"
section_id: "S01" # Ví dụ: S01, S02, S03
section_title: \"Tên section\" # Ví dụ: \"Giới thiệu về biến trong [Tên Ngôn Ngữ]\"
language_version: "1.0.0" # Phiên bản ngôn ngữ được dạy
review_score: 0.0
status: draft
```

Nếu thiếu bất kỳ trường nào trên – **DỪNG LẠI** và yêu cầu người dùng cung cấp trước khi tiếp tục.

---

## 4. Quy Trình Tạo Section (7 Bước)

### Bước 1: Hiểu Context Lesson

Trả lời rõ các câu hỏi sau:

- Lesson này dạy gì?
- Section này nằm ở vị trí nào trong lesson?
- Section trước đó (nếu có) đã dạy gì?
- Section tiếp theo (nếu có) sẽ dạy gì?
- Người học cần biết gì trước khi đọc section này?

### Bước 2: Xác Định Learner Level

Áp dụng tiêu chí phù hợp với level:

| Level     | Yêu cầu                                                                                        |
| --------- | ---------------------------------------------------------------------------------------------- |
| `begin`   | Không giả định kiến thức trước. Giải thích mọi khái niệm từ đầu. Dùng ví dụ đơn giản, gần gũi. |
| `advance` | Giả định đã biết [Tên Ngôn Ngữ] cơ bản. Tập trung vào cách dùng hiệu quả, pattern, và edge case.       |
| `master`  | Giả định có kinh nghiệm thực tế. Đi sâu vào internals, performance, và advanced patterns.      |

### Bước 3: Nghiên Cứu Chủ Đề

Tra cứu thông tin từ các nguồn được phép (xem `knowledge_sources.md`):

- Tài liệu chính thức của [Tên Ngôn Ngữ] (Ví dụ: Python Docs, Rust Docs, MSDN cho C#...)
- Các chỉ dẫn kỹ thuật, chuẩn đặt tên hoặc đặc tả (Ví dụ: PEPs, RFCs, Language specifications)
- Nhật ký thay đổi/Changelog của [Tên Ngôn Ngữ] để cập nhật tính năng mới nhất

Ghi chú nguồn tham khảo trong phần `## Nguồn Tham Khảo` của section.

### Bước 4: Tạo Nội Dung Section

Section phải theo đúng cấu trúc từ `template_section.md`.

Nội dung bắt buộc:

#### 4.1 Phần Giải Thích (Explanation)

- Giải thích khái niệm bằng ngôn ngữ tự nhiên, dễ hiểu.
- Dùng phép tương tự với cuộc sống thực tế.
- Giải thích TẠI SAO khái niệm này quan trọng.
- Độ dài: 150–400 từ (tùy độ phức tạp của chủ đề).

#### 4.2 Code Ví Dụ (Examples)

- Số lượng: Tối thiểu 2 ví dụ code, tối đa 5.
- Mỗi ví dụ phải có comment giải thích.
- Code phải chạy được với [Phiên Bản Ngôn Ngữ].
- Ví dụ đầu tiên: đơn giản nhất.
- Ví dụ cuối: thực tế và phức tạp hơn.

```[language]
# [Tên Ngôn Ngữ] [Phiên Bản Ngôn Ngữ]
# Sử dụng cú pháp hiện đại và chuẩn hóa của ngôn ngữ
# [Đoạn code minh họa hàm/biến...]
```

#### 4.3 Lỗi Thường Gặp (Common Mistakes)

- Liệt kê 2–4 lỗi phổ biến.
- Mỗi lỗi cần có: mô tả lỗi + code sai + code đúng + giải thích.

```python
# ❌ SAI
my_list = [1, 2, 3]
print(my_list[3])  # IndexError: list index out of range

# ✅ ĐÚNG
my_list = [1, 2, 3]
if len(my_list) > 3:
    print(my_list[3])
```

#### 4.4 Best Practices

- Liệt kê 2–3 best practice liên quan đến chủ đề.
- Tham chiếu PEP nếu có.

#### 4.5 Mini Exercise

- Đúng 1 bài tập nhỏ.
- Phải có: mô tả yêu cầu + input mẫu + output mong đợi.
- KHÔNG cung cấp lời giải ngay trong section (để Hermes tạo riêng).

#### 4.6 Tóm Tắt (Summary)

- 3–5 bullet points tóm lại nội dung chính.

---

### Bước 5: Tự Review Section

Sau khi viết xong nội dung, Hermes thực hiện self-review theo tiêu chí sau:

```json
{
  "self_review": {
    "technical_accuracy": {
      "score": 0,
      "note": "Code có chạy được không? API có tồn tại không?"
    },
    "teaching_quality": {
      "score": 0,
      "note": "Giải thích có rõ ràng không? Phù hợp với level không?"
    },
    "example_quality": {
      "score": 0,
      "note": "Ví dụ có thực tế không? Có đủ không?"
    },
    "exercise_quality": {
      "score": 0,
      "note": "Bài tập có phù hợp độ khó không?"
    },
    "format_compliance": {
      "score": 0,
      "note": "Có theo đúng template_section.md không?"
    },
    "total_score": 0,
    "pass": false,
    "weaknesses": [],
    "required_fixes": []
  }
}
```

Tính `total_score` = trung bình cộng của 5 tiêu chí.

### Bước 6: Xử Lý Kết Quả Review

```
Nếu total_score >= 8.0:
  → Tiến hành Bước 7 (Lưu file)

Nếu total_score >= 6.0 và < 8.0:
  → Thực hiện các required_fixes
  → Tăng chất lượng phần yếu nhất
  → Review lại (quay về Bước 5)
  → Tối đa 2 lần sửa; nếu vẫn < 8.0, báo cáo vấn đề

Nếu total_score < 6.0:
  → Xóa toàn bộ nội dung đã viết
  → Viết lại từ đầu với cách tiếp cận khác (Bước 4)
  → Tối đa 1 lần viết lại
```

### Bước 7: Lưu Section

Lưu vào đường dẫn đúng theo `file_naming_convention.md`:

```
output/sections/{level}/{lesson_id}_{section_id}_{slug}.md
```

Ví dụ:

```
output/sections/begin/L01_S01_bien-va-gia-tri.md
output/sections/advance/L03_S02_decorator-pattern.md
output/sections/master/L05_S01_metaclass-internals.md
```

---

## 5. Cấu Trúc Section Bắt Buộc

Xem `template_section.md` để lấy cấu trúc chi tiết.

Các heading bắt buộc theo thứ tự:

```markdown
---
id: ...
title: ...
sidebar_label: ...
sidebar_position: ...
level: ...
lesson_id: ...
lesson_title: ...
section_id: ...
section_title: ...
language_version: ...
review_score: 0.0
status: draft | reviewed | approved
---

# {Tên Section}

## Giới Thiệu

## Khái Niệm Chính

## Ví Dụ Code

## Lỗi Thường Gặp

## Best Practices

## Mini Exercise

## Tóm Tắt

## Nguồn Tham Khảo
```

---

## 6. Quy Tắc Dùng `template_section.md`

- Đọc toàn bộ `template_section.md` trước khi viết.
- Giữ nguyên thứ tự các heading.
- Giữ nguyên các field trong YAML frontmatter.
- Điền đúng giá trị vào `review_score` sau khi self-review.
- Điền `status: approved` chỉ khi score ≥ 8.0.

---

## 7. Output Mong Đợi

Khi hoàn thành, Hermes báo cáo:

```
✅ Section đã tạo: output/sections/begin/L01_S01_bien-va-gia-tri.md
📊 Self-review score: 8.5/10
🔍 Weaknesses: [...]
🔧 Applied fixes: [...]
📌 Status: approved
```
