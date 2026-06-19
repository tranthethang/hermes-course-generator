# Review Instruction

> **Dành cho:** Hermes AI Agent (đóng vai trò Reviewer)  
> **Mục đích:** Tiêu chí review nghiêm ngặt cho section và lesson.

---

## 1. Nguyên Tắc Review

> Khi review, Hermes đóng vai là một **reviewer độc lập**, không phải người viết nội dung đó.
>
> Nhiệm vụ: **Tìm ra điểm yếu** – không phải ca ngợi nội dung.

Quy tắc bắt buộc:

- Phải liệt kê ít nhất 1 `weakness` ngay cả khi nội dung tốt.
- Phải liệt kê `required_fixes` cụ thể, không chung chung.
- Điểm số phải phản ánh thực tế, không làm tròn lên.

---

## 2. Tiêu Chí Review Section (5 Chiều)

### Chiều 1: Chính Xác Kỹ Thuật (Technical Accuracy) — Trọng số 30%

| Điểm | Tiêu chí                                                                                         |
| ---- | ------------------------------------------------------------------------------------------------ |
| 9–10 | Tất cả code chạy được, API đúng, phiên bản [Tên Ngôn Ngữ] ghi rõ, không có hallucinated function |
| 7–8  | Code chạy được, có 1–2 lỗi nhỏ về style hoặc không tối ưu                                        |
| 5–6  | Code có lỗi runtime nhỏ hoặc dùng API lỗi thời (deprecated)                                      |
| 3–4  | Code có lỗi logic, API không tồn tại, hoặc thiếu xử lý exception                                 |
| 0–2  | Code sai hoàn toàn, hallucinated API, hoặc không thể chạy                                        |

Câu hỏi kiểm tra:

- Code có chạy được với [Phiên Bản Ngôn Ngữ] không?
- Có dùng API/module không tồn tại không?
- Type hints có đúng không?
- Exception handling có phù hợp không?
- Có ghi chú khi cần xác minh không?

### Chiều 2: Chất Lượng Giảng Dạy (Teaching Quality) — Trọng số 25%

| Điểm | Tiêu chí                                                                        |
| ---- | ------------------------------------------------------------------------------- |
| 9–10 | Giải thích rõ ràng, logic, phù hợp level, dùng phép tương tự tốt                |
| 7–8  | Giải thích đủ rõ nhưng thiếu một vài phép tương tự hoặc chưa giải thích tại sao |
| 5–6  | Giải thích tạm ổn nhưng khó theo dõi hoặc không phù hợp level                   |
| 3–4  | Giải thích không rõ ràng, quá ngắn, hoặc giả định kiến thức sai                 |
| 0–2  | Không giải thích, chỉ có code mà không có hướng dẫn                             |

Câu hỏi kiểm tra:

- Có giải thích trước khi đưa code không?
- Có phép tương tự gần gũi với cuộc sống không?
- Người học ở level `{level}` có hiểu được không?
- Có giải thích TẠI SAO không chỉ NHƯ THẾ NÀO?

### Chiều 3: Chất Lượng Ví Dụ (Example Quality) — Trọng số 20%

| Điểm | Tiêu chí                                                 |
| ---- | -------------------------------------------------------- |
| 9–10 | ≥2 ví dụ, thực tế, có comment, tăng độ phức tạp dần      |
| 7–8  | 2 ví dụ ổn nhưng 1 ví dụ quá đơn giản hoặc thiếu comment |
| 5–6  | Chỉ 1 ví dụ hoặc ví dụ không thực tế (chỉ `Hello World`) |
| 3–4  | Ví dụ không minh họa được khái niệm cần dạy              |
| 0–2  | Không có ví dụ hoặc ví dụ sai                            |

### Chiều 4: Chất Lượng Bài Tập (Exercise Quality) — Trọng số 15%

| Điểm | Tiêu chí                                                                             |
| ---- | ------------------------------------------------------------------------------------ |
| 9–10 | Bài tập rõ ràng, có input/output mẫu, phù hợp level, kiểm tra đúng kiến thức vừa học |
| 7–8  | Bài tập ổn nhưng thiếu input/output mẫu hoặc hơi khó/dễ                              |
| 5–6  | Bài tập mơ hồ hoặc không liên quan trực tiếp đến nội dung                            |
| 3–4  | Bài tập quá đơn giản (chỉ cần thay một giá trị) hoặc không thể giải quyết            |
| 0–2  | Không có bài tập                                                                     |

### Chiều 5: Tuân Thủ Format (Format Compliance) — Trọng số 10%

| Điểm | Tiêu chí                                                     |
| ---- | ------------------------------------------------------------ |
| 9–10 | Đầy đủ YAML frontmatter, đúng thứ tự heading, Markdown chuẩn |
| 7–8  | Đúng cấu trúc nhưng thiếu 1–2 trường trong frontmatter       |
| 5–6  | Thiếu một số heading bắt buộc                                |
| 3–4  | Sai cấu trúc đáng kể so với template                         |
| 0–2  | Không theo template                                          |

---

## 3. Công Thức Tính Điểm

```
total_score = (
  technical_accuracy +
  teaching_quality +
  example_quality +
  exercise_quality +
  format_compliance
) / 5
```

Làm tròn đến 1 chữ số thập phân.

---

## 4. Điều Kiện Pass / Fail

| Kết quả      | Điều kiện                  | Hành động                            |
| ------------ | -------------------------- | ------------------------------------ |
| **APPROVED** | `total_score >= 8.0`       | Lưu file với `status: approved`      |
| **REVISE**   | `6.0 <= total_score < 8.0` | Sửa các `required_fixes`, review lại |
| **REWRITE**  | `total_score < 6.0`        | Viết lại toàn bộ section từ đầu      |

---

## 5. Output Review — Định Dạng JSON

Hermes PHẢI xuất kết quả review theo đúng format JSON sau:

```json
{
  "review_type": "section",
  "target_file": "output/sections/begin/L01_S01_bien-va-gia-tri.mdx",
  "review_timestamp": "2026-06-18T10:00:00+07:00",
  "scores": {
    "technical_accuracy": {
      "score": 8.5,
      "notes": "Code chạy được, type hints đúng. Thiếu xử lý ValueError trong ví dụ 2."
    },
    "teaching_quality": {
      "score": 9.0,
      "notes": "Giải thích rõ ràng, phép tương tự tốt. Đúng level begin."
    },
    "example_quality": {
      "score": 8.0,
      "notes": "3 ví dụ tốt. Ví dụ 2 thiếu comment giải thích dòng phức tạp."
    },
    "exercise_quality": {
      "score": 7.5,
      "notes": "Bài tập rõ ràng nhưng thiếu output mẫu cụ thể."
    },
    "format_compliance": {
      "score": 10.0,
      "notes": "Đầy đủ YAML, đúng thứ tự heading, Markdown sạch."
    }
  },
  "total_score": 8.6,
  "result": "APPROVED",
  "strengths": [
    "Giải thích khái niệm biến rất rõ ràng cho người mới",
    "Phép tương tự 'hộp đựng đồ' dễ hiểu",
    "Liệt kê 3 lỗi thường gặp thực tế"
  ],
  "weaknesses": [
    "Ví dụ 2 thiếu comment giải thích phần list comprehension phức tạp",
    "Bài tập thiếu output mẫu cụ thể"
  ],
  "required_fixes": [
    {
      "priority": "medium",
      "location": "## Ví Dụ Code > Ví dụ 2",
      "issue": "Thiếu comment cho dòng list comprehension",
      "fix": "Thêm comment '#  Tạo list số chẵn từ 0 đến 20' trước dòng đó"
    },
    {
      "priority": "low",
      "location": "## Mini Exercise",
      "issue": "Thiếu output mẫu",
      "fix": "Thêm 'Output mong đợi: [2, 4, 6, 8, 10]'"
    }
  ]
}
```

---

## 6. Output Review — Định Dạng Markdown (Thay Thế)

Nếu cần trình bày cho người đọc (không phải machine), dùng format Markdown:

```markdown
## Kết Quả Review

**File:** `output/sections/begin/L01_S01_bien-va-gia-tri.mdx`  
**Thời gian:** 2026-06-18 10:00 +07:00  
**Loại:** Section Review

### Điểm Số

| Tiêu chí            | Điểm         |
| ------------------- | ------------ |
| Technical Accuracy  | 8.5          |
| Teaching Quality    | 9.0          |
| Example Quality     | 8.0          |
| Exercise Quality    | 7.5          |
| Format Compliance   | 10.0         |
| **TỔNG TRUNG BÌNH** | **8.6 / 10** |

### Kết Quả: ✅ APPROVED

### Điểm Mạnh

- ...

### Điểm Yếu

- ...

### Các Fix Bắt Buộc

1. [MEDIUM] ...
2. [LOW] ...
```

---

## 7. Review Lesson (Sau Khi Merge)

Khi review lesson đã merge, dùng thêm các tiêu chí:

| Tiêu chí bổ sung | Mô tả                                                   |
| ---------------- | ------------------------------------------------------- |
| **Flow**         | Các section có liên kết mạch lạc không?                 |
| **Completeness** | Lesson có đủ Introduction, Recap, Exercise, Quiz không? |
| **Consistency**  | Thuật ngữ có nhất quán xuyên suốt lesson không?         |
| **Duplication**  | Có nội dung trùng lặp không cần thiết không?            |

Lưu kết quả review lesson vào:

```
output/reviews/lessons/{level}/{lesson_id}_review.json
```

---

## 8. Quy Tắc Lưu File Review

Mọi kết quả review phải được lưu file để truy vết:

```
output/reviews/sections/{level}/{lesson_id}_{section_id}_review.json
output/reviews/lessons/{level}/{lesson_id}_review.json
```

Ví dụ:

```
output/reviews/sections/begin/L01_S01_review.json
output/reviews/lessons/advance/L02_review.json
```
