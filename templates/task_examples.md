# Task Examples

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Cung cấp ví dụ thực tế cho từng loại task (Tạo Section, Review, Fix Section, Merge Lesson, Tạo Changelog).

---

## 1. Ví Dụ Task 1: Tạo Section (Task: generate_section)

### Yêu Cầu Từ User

```
Hãy tạo Section S01 cho Lesson L01 thuộc level "begin".
Tên Lesson: "Biến và Kiểu Dữ Liệu Cơ Bản"
Tên Section: "Khái niệm về Biến và Gán Giá Trị"
```

### Response Thực Tế Từ Hermes (Sau khi chạy workflow)

`````markdown
# Tiến trình thực hiện: generate_section (begin - L01_S01)

1. Đã đọc `overview.md`, `architecture.md` để lấy context.
2. Xác định level: `begin` (không giả định kiến thức lập trình).
3. Đã tra cứu tài liệu Python 3.12 về phép gán và đặt tên biến.
4. Đã tự review và sửa 1 lỗi thiếu ví dụ code thực tế.

---

### Nội dung file được ghi: `output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md`

````markdown
---
level: begin
lesson_id: L01
lesson_title: "Biến và Kiểu Dữ Liệu Cơ Bản"
section_id: S01
section_title: "Khái niệm về Biến và Gán Giá Trị"
language_version: "3.12+"
review_score: 8.8
status: approved
---

# Khái niệm về Biến và Gán Giá Trị

## Giới Thiệu

Trong lập trình, chúng ta luôn cần lưu trữ thông tin để sử dụng lại sau đó. Hãy tưởng tượng bạn đang quản lý một cửa hàng trực tuyến, bạn cần ghi nhớ giá của một sản phẩm hoặc tên của khách hàng. Đó là lý do chúng ta cần đến **Biến** (variables).

## Khái Niệm Chính

Biến giống như một chiếc hộp có dán nhãn bên ngoài. Nhãn của hộp là **Tên biến**, còn đồ vật bên trong hộp là **Giá trị của biến**.

Phép gán (assignment) trong Python sử dụng dấu bằng (`=`). Nó có nghĩa là: "Hãy lấy giá trị ở bên phải và đặt vào chiếc hộp có tên ở bên trái".

## Ví Dụ Code

```python
# Python 3.12+

# 1. Khai báo biến lưu tên và tuổi của một học sinh
ten_hoc_sinh: str = "Nguyễn Văn A"
tuoi_hoc_sinh: int = 15

print(ten_hoc_sinh)  # In ra: Nguyễn Văn A
print(tuoi_hoc_sinh) # In ra: 15

# 2. Thay đổi giá trị của biến (gán lại giá trị mới)
so_luong_ton_kho: int = 10
so_luong_ton_kho = so_luong_ton_kho - 2
print(so_luong_ton_kho)  # In ra: 8
```
````
`````

## Lỗi Thường Gặp

### 1. Nhầm lẫn chiều của phép gán

Người mới học thường nhầm lẫn giữa vế trái và vế phải.

```python
# ❌ SAI
15 = tuoi  # SyntaxError: cannot assign to literal here

# ✅ ĐÚNG
tuoi = 15
```

### 2. Sử dụng biến trước khi khai báo

Bạn không thể lấy đồ từ một chiếc hộp chưa tồn tại.

```python
# ❌ SAI
print(diem_so)  # NameError: name 'diem_so' is not defined

# ✅ ĐÚNG
diem_so = 9.5
print(diem_so)
```

## Best Practices

- **Đặt tên biến có nghĩa:** Sử dụng `so_luong_sach` thay vì `x` hoặc `sl`.
- **Tuân thủ PEP 8:** Dùng chữ thường và dấu gạch dưới (snake_case) cho tên biến. Ví dụ: `ten_dang_nhap`.
- **Dùng Type Hints:** Thêm kiểu dữ liệu để code rõ ràng hơn (như `tuoi: int = 18`).

## Mini Exercise

**Yêu cầu:** Viết một đoạn chương trình khai báo 3 biến: `ten_san_pham`, `gia_tien`, và `so_luong`. Sau đó tính tổng số tiền (giá tiền nhân số lượng) và gán vào biến `tong_tien`. Cuối cùng, in ra màn hình `tong_tien`.

- Input mẫu: `ten_san_pham = "Sách Python"`, `gia_tien = 50000`, `so_luong = 3`
- Output mong đợi: `150000`

## Tóm Tắt

- Biến dùng để lưu trữ dữ liệu trong bộ nhớ.
- Cú pháp gán biến: `ten_bien = gia_tri`.
- Tên biến nên viết thường, dùng snake_case và có ý nghĩa rõ ràng.

## Nguồn Tham Khảo

- [Python Docs: Informal Introduction to Python - Variables](https://docs.python.org/3/tutorial/introduction.html#numbers)
- [PEP 8 - Naming Conventions](https://peps.python.org/pep-0008/#naming-conventions)

```

```

📊 **Báo cáo Self-review:**

- Technical Accuracy: 9.0/10 (Code chạy tốt, có type hints)
- Teaching Quality: 9.0/10 (Phép tương tự hộp đựng rất dễ hiểu)
- Example Quality: 8.5/10 (Có 2 ví dụ thực tế)
- Exercise Quality: 8.5/10 (Bài tập thực tế, có input/output rõ ràng)
- Format Compliance: 9.0/10 (Khớp hoàn toàn template)
- **Tổng điểm: 8.8/10 (APPROVED)**

`````

---

## 2. Ví Dụ Task 2: Review Section (Task: review_section)

### Yêu Cầu Từ User

```
Hãy review file section sau: output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md
```

### Response Thực Tế Từ Hermes (Ghi file JSON review)

```json
{
  "review_type": "section",
  "target_file": "output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md",
  "review_timestamp": "2026-06-18T13:52:00+07:00",
  "scores": {
    "technical_accuracy": {
      "score": 9.0,
      "weight": 0.3,
      "notes": "Code hoàn toàn chính xác theo Python 3.12+ style. Không có cú pháp lỗi."
    },
    "teaching_quality": {
      "score": 9.0,
      "weight": 0.25,
      "notes": "Giải thích trực quan tốt cho đối tượng bắt đầu."
    },
    "example_quality": {
      "score": 8.0,
      "weight": 0.2,
      "notes": "Các ví dụ tốt nhưng ví dụ 2 (gán lại) nên có thêm giải thích chi tiết về luồng thực thi từ phải qua trái."
    },
    "exercise_quality": {
      "score": 8.0,
      "weight": 0.15,
      "notes": "Bài tập phù hợp, tuy nhiên có thể hướng dẫn học viên không cần viết hàm cho bài tập cơ bản này."
    },
    "format_compliance": {
      "score": 10.0,
      "weight": 0.1,
      "notes": "Đầy đủ YAML và heading."
    }
  },
  "total_score": 8.75,
  "result": "APPROVED",
  "strengths": [
    "Sử dụng phép tương tự hộp đựng trực quan, sinh động.",
    "Lỗi thường gặp chọn lọc đúng những lỗi người mới hay mắc."
  ],
  "weaknesses": [
    "Phần giải thích ví dụ 2 gán lại biến (`so_luong_ton_kho = so_luong_ton_kho - 2`) chưa giải thích kỹ rằng máy tính tính toán vế phải trước rồi mới ghi đè vào vế trái."
  ],
  "required_fixes": [
    {
      "priority": "low",
      "location": "## Ví Dụ Code > Ví dụ 2",
      "issue": "Thiếu giải thích cách hoạt động của dòng gán đè self-referencing",
      "fix": "Thêm một câu giải thích ngắn: 'Dòng lệnh này hoạt động bằng cách: Lấy giá trị hiện tại của so_luong_ton_kho (10) trừ đi 2 được 8, sau đó cất lại số 8 vào chính chiếc hộp đó.'"
    }
  ]
}
```

---

## 3. Ví Dụ Task 3: Sửa Section (Task: fix_section)

### Yêu Cầu Từ User

```
Hãy sửa file section L01_S01 dựa trên file review JSON tương ứng.
```

### Response Thực Tế Từ Hermes (Sau khi sửa và ghi lại file)

````markdown
### Tiến trình thực hiện: Sửa section L01_S01 theo review

1. Đã đọc file review `output/reviews/sections/begin/L01_S01_review.json`.
2. Xác định fix cần thực hiện: Thêm giải thích dòng gán đè biến trong Ví dụ 2.
3. Thực hiện sửa đổi trong code content.
4. Chạy lại self-review.

---

### Đoạn thay đổi (Diff):

```diff
 # 2. Thay đổi giá trị của biến (gán lại giá trị mới)
 so_luong_ton_kho: int = 10
 so_luong_ton_kho = so_luong_ton_kho - 2
+# Giải thích: Máy tính sẽ tính toán vế phải trước (10 - 2 = 8), sau đó gán đè giá trị 8 vào biến so_luong_ton_kho.
 print(so_luong_ton_kho)  # In ra: 8
```

---

📊 **Báo cáo lại:**

- File đã được cập nhật thành công.
- Điểm review mới: **8.9/10** (Tăng do cải thiện phần giải thích ví dụ).
- Status: **approved**.
- Changelog đã được cập nhật.
`````

---

## 4. Ví Dụ Task 4: Merge Lesson (Task: merge_lesson)

### Yêu Cầu Từ User

```
Hãy merge các section của Lesson L01 level "begin" thành file lesson hoàn chỉnh.
```

### Response Thực Tế Từ Hermes

`````markdown
### Tiến trình thực hiện: merge_lesson (begin - L01)

1. Đã kiểm tra trạng thái các section:
   - `L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md` -> APPROVED (Score: 8.9)
   - `L01_S02_kieu-du-lieu-so-va-chuoi.md` -> APPROVED (Score: 9.0)
   - `L01_S03_nhap-xuat-du-lieu.md` -> APPROVED (Score: 8.5)
2. Không phát hiện trùng lặp ví dụ. Đã viết thêm phần Giới thiệu tổng quan, Ôn tập, Bài tập tổng hợp và Quiz trắc nghiệm.

---

### Nội dung file được ghi: `output/lessons/begin/L01_bien-va-kieu-du-lieu.md`

````markdown
---
level: begin
lesson_id: L01
lesson_title: "Biến và Kiểu Dữ Liệu Cơ Bản"
section_count: 3
sections:
  - id: S01
    title: "Khái niệm về Biến và Gán Giá Trị"
    file: "L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md"
  - id: S02
    title: "Kiểu Dữ Liệu Số và Chuỗi"
    file: "L01_S02_kieu-du-lieu-so-va-chuoi.md"
  - id: S03
    title: "Nhập Xuất Dữ Liệu cơ bản"
    file: "L01_S03_nhap-xuat-du-lieu.md"
language_version: "3.12+"
status: draft
created_at: "2026-06-18"
---

# Bài 1: Biến và Kiểu Dữ Liệu Cơ Bản

## Giới Thiệu Lesson

Chào mừng bạn đến với bài học đầu tiên trong chương trình Python cơ bản. Trong bài học này, chúng ta sẽ cùng đặt những viên gạch đầu tiên thông qua các khái niệm về cách máy tính lưu trữ và hiển thị dữ liệu.

**Mục tiêu học tập:**
Sau bài học này, bạn sẽ có thể:

- [ ] Khai báo và gán giá trị cho biến một cách thành thạo.
- [ ] Phân biệt được kiểu dữ liệu Số (int, float) và Chuỗi (str).
- [ ] Nhận dữ liệu nhập vào từ người dùng và in kết quả ra màn hình.

**Thời gian ước tính:** 2 giờ.

---

## Phần 1: Khái niệm về Biến và Gán Giá Trị

[Nội dung từ S01...]

---

## Phần 2: Kiểu Dữ Liệu Số và Chuỗi

[Nội dung từ S02...]

---

## Phần 3: Nhập Xuất Dữ Liệu cơ bản

[Nội dung từ S03...]

---

## Ôn Tập Lesson

Tóm tắt các điểm quan trọng bạn cần ghi nhớ:

1. **Biến:** Là tên đại diện cho một phân vùng bộ nhớ dùng để chứa dữ liệu.
2. **Kiểu dữ liệu:** Python có kiểu số nguyên (`int`), số thực (`float`), và chuỗi ký tự (`str`).
3. **Hàm hỗ trợ:** Dùng `print()` để xuất dữ liệu và `input()` để nhập dữ liệu.

## Bài Tập Tổng Hợp

### Bài 1: Tính Tiền Đi Chợ (Cơ bản)

**Yêu cầu:** Viết chương trình yêu cầu người dùng nhập tên một loại hoa quả, giá tiền trên mỗi kg (số thực), và số lượng kg muốn mua (số thực). Hãy tính và in ra hóa đơn theo mẫu dưới đây.

**Ví dụ chạy chương trình:**

```text
Nhập tên quả: Quả Táo
Nhập đơn giá: 45000.5
Nhập số lượng (kg): 2.5
Hóa đơn quả Táo: 112501.25 VNĐ
```
````
`````

## Quiz

### Câu 1: Đâu là tên biến hợp lệ theo chuẩn PEP 8 trong Python?

- A) `User-Name`
- B) `user_name`
- C) `userName`
- D) `1_user_name`

<details>
<summary>📖 Xem đáp án</summary>

**Đáp án: B) `user_name`**

Giải thích: PEP 8 khuyến nghị dùng kiểu snake_case (chữ thường nối nhau bằng dấu gạch dưới) đối với biến. Đáp án D không hợp lệ vì tên biến không được bắt đầu bằng số.

</details>
```
```

---

## 5. Ví Dụ Task 5: Tạo Changelog Entry

### File `output/changelog.md` sau các task trên:

```markdown
# Changelog

Tất cả các thay đổi lớn nhỏ đối với khóa học Python sẽ được ghi lại tại đây.

## [2026-06-18 13:55:00 +07:00]

### Created

- `output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md` — score: 8.8 (approved)

### Reviews

- `output/reviews/sections/begin/L01_S01_review.json` — APPROVED (Score: 8.75)

---

## [2026-06-18 14:05:00 +07:00]

### Modified

- `output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.md` — Cập nhật thêm phần giải thích ví dụ 2 theo feedback review. Score mới: 8.9 (approved)

### Merged

- `output/lessons/begin/L01_bien-va-kieu-du-lieu.md` — Đã gộp thành công 3 sections (S01, S02, S03). Status: draft.
```

```

```
