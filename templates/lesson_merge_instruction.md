# Lesson Merge Instruction

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Hướng dẫn quy trình merge nhiều section thành một lesson hoàn chỉnh thông qua CLI và
> điền các placeholder.

---

## 1. Điều Kiện Tiên Quyết

Hermes KHÔNG được bắt đầu merge nếu chưa đủ điều kiện:

- [ ] Tất cả các section cho lesson đó đã có file trong `output/sections/{level}/`
- [ ] Lệnh check status hoặc review cho thấy tất cả section đều đã approved.
- [ ] Đã xác định đúng `level`, `lesson_id`

---

## 2. Quy Trình Merge (3 Bước)

### Bước 1: Gọi lệnh CLI để gộp file cơ học

Thay vì tự copy paste nội dung, Agent **PHẢI** gọi lệnh CLI:

```bash
hermes-course-generator merge --level {level} --lesson {lesson_id}
```

**Kết quả của lệnh này:**

- CLI sẽ tự động tìm tất cả các file section `.mdx` tương ứng.
- CLI sẽ tự động ghép chúng lại với nhau theo thứ tự.
- CLI sẽ tự tạo file `output/lessons/{level}/{lesson_id}_{slug}.mdx`.
- CLI sẽ chèn sẵn các chuỗi placeholder dạng `<!-- HERMES:FILL ... -->` vào file.

### Bước 2: Mở file và điền Placeholder

Sau khi lệnh CLI chạy xong thành công, Agent sử dụng tool chỉnh sửa file để mở file `.mdx` vừa được
tạo ra.

Nhiệm vụ của Agent là **chỉ** tìm các dòng chứa `<!-- HERMES:FILL ... -->` và thay thế chúng bằng
nội dung do Agent sáng tạo ra, bao gồm:

1. `<!-- HERMES:FILL lesson_introduction -->`: Viết đoạn giới thiệu lesson (100-200 từ).
2. `<!-- HERMES:FILL learning_objectives -->`: Liệt kê các mục tiêu học tập (3-5 mục).
3. `<!-- HERMES:FILL prerequisites -->`: Yêu cầu kiến thức trước.
4. `<!-- HERMES:FILL time_estimate -->`: Thời gian học dự kiến.
5. `<!-- HERMES:FILL lesson_recap -->`: Ôn tập tóm gọn toàn bộ lesson (5-8 bullet points).
6. `<!-- HERMES:FILL comprehensive_exercises -->`: Sinh 2-3 bài tập kết hợp kiến thức từ nhiều
   section.
7. `<!-- HERMES:FILL quiz_5_questions -->`: Sinh 5 câu hỏi trắc nghiệm khách quan (với thẻ
   `<details>` để giấu đáp án).

**Lưu ý cực kỳ quan trọng:**

- **KHÔNG ĐƯỢC** thay đổi phần nội dung code hoặc văn bản của các section đã được CLI copy vào. Mục
  đích là để bảo toàn 100% chất lượng đã review.
- Phải xóa các dòng `<!-- HERMES:FILL ... -->` sau khi đã thay thế bằng nội dung thật.

### Bước 3: Kiểm Tra Lesson Hoàn Chỉnh

Sau khi điền placeholder, chạy checklist trong `quality_checklist.md` phần "Checklist trước khi
merge lesson".

Đặc biệt kiểm tra:

- Các phần Intro, Recap, Exercises, và Quiz có mạch lạc và phù hợp với nội dung các section không?
- Định dạng Markdown có bị vỡ không?

---

## 3. Những Điều KHÔNG Được Làm Khi Merge

- ❌ KHÔNG tự mình copy paste nội dung các section (Phải để CLI làm việc này).
- ❌ KHÔNG chỉnh sửa nội dung bên trong của các section đã được nối vào file lesson.
- ❌ KHÔNG merge khi còn section chưa được approved.

---

## 4. Output Báo Cáo Sau Merge

Khi hoàn thành, Agent báo cáo:

```
✅ Lesson đã merge bằng CLI và điền placeholder: output/lessons/advance/L02_ham-va-closures.mdx
➕ Nội dung đã thêm: Introduction, Recap, 2 Exercises, 5 Quiz questions
📌 Lesson status: draft (cần review tổng thể trước khi published)
```
