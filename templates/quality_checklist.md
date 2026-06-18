# Quality Checklist

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Danh sách kiểm tra bắt buộc trước khi lưu section hoặc merge lesson.

---

## Hướng Dẫn Dùng

- Chạy checklist **trước khi lưu** bất kỳ file nào.
- Đánh dấu `[x]` cho mỗi mục đã kiểm tra.
- Nếu bất kỳ mục `[REQUIRED]` nào chưa đạt → **KHÔNG lưu file**.
- Mục `[OPTIONAL]` không đạt thì ghi chú nhưng vẫn cho phép lưu.

---

## Checklist 1: Trước Khi Lưu Section

### A. Kỹ Thuật Ngôn Ngữ [REQUIRED]

````
[ ] Code trong section đã được kiểm tra cú pháp (không có SyntaxError)
[ ] Tất cả function/class/module được nhắc đến đều tồn tại trong phiên bản ngôn ngữ được chỉ định
[ ] Type hints / static typing đúng (nếu có sử dụng)
[ ] Không có hallucinated API (API bịa đặt không tồn tại)
[ ] Import / using / include statements đúng và đầy đủ
[ ] Exception / Error handling phù hợp với context (không try/catch quá rộng)
[ ] Không có code deprecated mà không ghi chú rõ ràng
[ ] Code tuân thủ quy chuẩn style guide của ngôn ngữ
[ ] Mỗi code block đều có khai báo ngôn ngữ (ví dụ: ```rust, ```csharp, ```python)
````

### B. Tính Sư Phạm [REQUIRED]

```
[ ] Có phần giải thích khái niệm TRƯỚC code ví dụ
[ ] Giải thích phù hợp với level (begin/advance/master)
[ ] Không giả định kiến thức vượt level (đặc biệt với begin)
[ ] Có ít nhất 2 ví dụ code
[ ] Ví dụ đầu tiên đơn giản nhất, ví dụ sau phức tạp hơn
[ ] Có phần Lỗi Thường Gặp với ít nhất 2 lỗi
[ ] Có phần Best Practices với ít nhất 2 điểm
[ ] Có Mini Exercise rõ ràng (có input và output mẫu)
[ ] Có Tóm Tắt cuối section (3–5 bullet points)
```

### C. Format Markdown & Docusaurus [REQUIRED]

```
[ ] YAML frontmatter đầy đủ Docusaurus format (id, title, sidebar_label, sidebar_position, level, lesson_id, section_id, language_version, review_score, status)
[ ] Sử dụng Docusaurus Admonitions (:::note, :::tip, :::info, :::warning, :::danger) thay vì Github-style (> [!NOTE])
[ ] MDX Safety: Không chứa các tag giả trần trụi (như <T>, <string>) trong text bình thường. Tất cả đều phải viết trong code block, inline code hoặc được escape.
[ ] Thứ tự heading đúng theo template_section.md
[ ] Heading không skip level (không đi từ ## thẳng xuống ####)
[ ] Code block dùng triple backtick với ngôn ngữ chỉ định
[ ] Không có broken link
[ ] Bảng (table) được format đúng Markdown
[ ] Không có heading trùng nhau trong một section
```

### D. Nội Dung [REQUIRED]

```
[ ] Tên file theo đúng quy tắc file_naming_convention.md
[ ] Thuật ngữ nhất quán trong toàn section
[ ] Không có nội dung copy-paste nguyên văn từ nguồn ngoài
[ ] Viết bằng tiếng Việt (ngoại trừ thuật ngữ kỹ thuật tiếng Anh)
[ ] Thông tin không chắc đã được gắn tag ⚠️ CẦN XÁC MINH
[ ] Có phần Nguồn Tham Khảo (ít nhất 1 nguồn)
```

### E. Review Score [REQUIRED]

```
[ ] Đã tự review theo review_instruction.md
[ ] review_score đã được điền vào YAML frontmatter
[ ] review_score >= 8.0
[ ] status: approved (chỉ khi score >= 8.0)
[ ] File review JSON đã được lưu vào output/reviews/sections/
```

### F. Chất Lượng Tùy Chọn [OPTIONAL]

```
[ ] Có phép tương tự hoặc hình ảnh trực quan cho khái niệm phức tạp
[ ] Code ví dụ có giá trị thực tế (không chỉ Hello World)
[ ] Bài tập có nhiều mức độ (cơ bản / nâng cao)
[ ] Có gợi ý (hint) cho bài tập nhưng không phá lộ lời giải
```

---

## Checklist 2: Trước Khi Merge Lesson

### A. Điều Kiện Tiên Quyết [REQUIRED]

```
[ ] Tất cả section files đã tồn tại trong output/sections/{level}/
[ ] Tất cả section đều có status: approved
[ ] Tất cả section đều có review_score >= 8.0
[ ] Section IDs liên tiếp không bị thiếu (S01, S02, S03...)
[ ] Đã đọc template_lesson.md
```

### B. Cấu Trúc Lesson [REQUIRED]

```
[ ] YAML frontmatter của lesson đầy đủ Docusaurus format (id, title, sidebar_label, sidebar_position, ...)
[ ] Có phần Giới Thiệu Lesson (mục tiêu học tập, prerequisites, thời gian) sử dụng Docusaurus info admonition cho learning objectives
[ ] Sections được sắp xếp đúng thứ tự (S01 → S02 → ...) và sidebar_position tương ứng
[ ] Có phần Ôn Tập Lesson cuối lesson
[ ] Có ít nhất 2 Bài Tập Tổng Hợp
[ ] Có Quiz (5 câu, có đáp án hidden trong <details> tag)
```

### C. Xử Lý Nội Dung [REQUIRED]

```
[ ] Đã loại bỏ nội dung trùng lặp rõ ràng giữa các section
[ ] Thuật ngữ nhất quán xuyên suốt lesson
[ ] Transition text giữa các section (câu dẫn từ section này sang section tiếp theo)
[ ] Không xóa ví dụ code hữu ích dù có vẻ trùng
[ ] Không thay đổi ý nghĩa code khi chỉnh sửa
```

### D. Format Lesson [REQUIRED]

```
[ ] Tên file lesson theo đúng quy tắc file_naming_convention.md
[ ] Heading hierarchy đúng
[ ] Tất cả section ID và title trong YAML frontmatter khớp với nội dung thực tế
[ ] Không có broken link hoặc tham chiếu sai
```

### E. Bài Tập Tổng Hợp [REQUIRED]

```
[ ] Ít nhất 2 bài tập kết hợp kiến thức từ nhiều section
[ ] Mỗi bài tập có: tiêu đề, mô tả, input mẫu, output mong đợi
[ ] Độ khó tăng dần giữa các bài tập
[ ] Bài tập phù hợp với level của lesson
```

### F. Quiz [REQUIRED]

```
[ ] Đúng 5 câu hỏi
[ ] Mỗi câu có đúng 4 đáp án (A, B, C, D)
[ ] Chỉ 1 đáp án đúng cho mỗi câu
[ ] Đáp án nằm trong <details> tag (hidden)
[ ] Có giải thích ngắn cho đáp án đúng
[ ] Phân bố: 2 câu lý thuyết, 2 câu đọc code, 1 câu debug
```

---

## Checklist 3: Kỹ Thuật [Tên Ngôn Ngữ] Nâng Cao (Cho Level Advance và Master)

Áp dụng bổ sung cho section/lesson thuộc `advance` hoặc `master`:

```
[ ] Type hints đầy đủ và chính xác (đặc biệt Generic types, Protocol)
[ ] Đã đề cập đến performance implications (nếu có)
[ ] Đã nêu rõ thread safety / async safety (nếu liên quan)
[ ] Đã so sánh với cách tiếp cận alternative khi có nhiều cách giải quyết
[ ] Ví dụ code không quá đơn giản so với level
[ ] Đề cập chuẩn/tài liệu đặc tả liên quan (như PEP, RFC, specifications) khi thảo luận về design decision
```

---

## Checklist 4: Level-Specific

### Level Begin

```
[ ] Không dùng list comprehension mà chưa giải thích trước
[ ] Không dùng lambda mà chưa giải thích function cơ bản
[ ] Không dùng decorator mà chưa giải thích function là object
[ ] Mỗi khái niệm mới đều có phép tương tự dễ hiểu
[ ] Không giả định người đọc biết OOP
```

### Level Advance

```
[ ] Đã giải thích WHY (tại sao dùng pattern này), không chỉ HOW
[ ] Có đề cập edge case và cách xử lý
[ ] Có ví dụ realistic (không chỉ ví dụ đơn giản hóa)
[ ] Đề cập đến testing nếu phù hợp
```

### Level Master

```
[ ] Có thảo luận về performance (time/space complexity khi có liên quan)
[ ] Có đề cập đến kiến trúc runtime/compiler internals của [Tên Ngôn Ngữ] nếu phù hợp
[ ] Có so sánh với các pattern/approach khác
[ ] Code ví dụ ở mức production-ready
[ ] Đề cập đến maintainability và scalability
```

---

## Tổng Kết Nhanh

Trước khi nhấn lưu, trả lời 3 câu hỏi này:

> 1. **Code có chạy được không?** Nếu không → Sửa trước.
> 2. **Review score có ≥ 8.0 không?** Nếu không → Sửa trước.
> 3. **Tất cả REQUIRED checklist đã tick không?** Nếu không → Sửa trước.

Chỉ lưu khi cả 3 câu đều là **CÓ**.
