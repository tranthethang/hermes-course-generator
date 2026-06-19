# File Naming Convention

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Quy tắc đặt tên file, tạo slug không dấu, và cấu trúc thư mục đầu ra trong project.

---

## 1. Quy Tắc Tạo Slug (Slugification Rules)

Slug là chuỗi ký tự được dùng làm tên file để thân thiện với hệ thống tệp và URL.

### Quy tắc tạo Slug bắt buộc:

1. **Chuyển thành chữ thường (Lowercase):** Không viết hoa bất kỳ ký tự nào.
2. **Loại bỏ dấu tiếng Việt:** Chuyển các chữ có dấu thành không dấu (ví dụ: `đ` -> `d`, `á` -> `a`,
   `ơ` -> `o`).
3. **Thay khoảng trắng bằng dấu gạch ngang (`-`):** Không dùng khoảng trắng hoặc dấu gạch dưới (`_`)
   trong slug.
4. **Loại bỏ ký tự đặc biệt:** Xóa bỏ tất cả các ký tự như `?`, `!`, `,`, `.`, `:`, `/`, `(`, `)`,
   `"`, `'`...
5. **Chỉ giữ lại chữ cái thường (a-z), chữ số (0-9) và dấu gạch ngang (-).**

### Ví dụ chuyển đổi:

- `"Khái niệm về Biến & Gán Giá Trị!"`  
  ➔ `khai-niem-ve-bien-va-gan-gia-tri`
- `"Làm việc với f-string (Python 3.12+)"`  
  ➔ `lam-viec-vui-f-string-python-312`
- `"Decorator & OOP nâng cao"`  
  ➔ `decorator-va-oop-nang-cao`

---

## 2. Quy Tắc Đặt Tên File (File Naming Rules)

### 2.1 Đối với Section (Bài Học Nhỏ)

Format:

```
{lesson_id}_{section_id}_{slug}.mdx
```

- `{lesson_id}`: Định dạng `L` + 2 chữ số (ví dụ: `L01`, `L12`).
- `{section_id}`: Định dạng `S` + 2 chữ số (ví dụ: `S01`, `S05`).
- `{slug}`: Slug được tạo từ tiêu đề của section đó.

Ví dụ cụ thể:

- `L01_S01_khai-niem-ve-bien-va-gan-gia-tri.mdx`
- `L02_S03_closures-va-bien-nonlocal.mdx`

### 2.2 Đối với Lesson (Bài Học Lớn - Sau Khi Merge)

Format:

```
{lesson_id}_{slug}.mdx
```

- `{lesson_id}`: Định dạng `L` + 2 chữ số.
- `{slug}`: Slug được tạo từ tiêu đề lớn của lesson đó.

Ví dụ cụ thể:

- `L01_bien-va-kieu-du-lieu-co-ban.mdx`
- `L02_ham-va-pham-vi-bien.mdx`

### 2.3 Đối với File Review (Đánh Giá Chất Lượng)

#### A. Review của Section

Format:

```
{lesson_id}_{section_id}_review.json
```

Ví dụ cụ thể:

- `L01_S01_review.json`
- `L02_S03_review.json`

#### B. Review của Lesson

Format:

```
{lesson_id}_review.json
```

Ví dụ cụ thể:

- `L01_review.json`

---

## 3. Cấu Trúc Thư Mục `output/`

Toàn bộ file đầu ra phải được đặt chính xác trong các thư mục con sau. Hermes có trách nhiệm tự động
tạo thư mục này nếu chúng chưa tồn tại.

```text
output/
├── changelog.md                       # Nhật ký thay đổi chung của project
├── sections/                          # Nơi lưu trữ các file section đơn lẻ
│   ├── begin/                         # Các section trình độ Newbie (Beginner)
│   ├── advance/                       # Các section trình độ Trung cấp (Advanced)
│   └── master/                        # Các section trình độ Chuyên gia (Master)
├── lessons/                           # Nơi lưu các lesson đã được merge hoàn chỉnh
│   ├── begin/
│   ├── advance/
│   └── master/
└── reviews/                           # Nơi lưu trữ các đánh giá chất lượng (JSON)
    ├── sections/                      # Đánh giá cho từng section riêng lẻ
    │   ├── begin/
    │   ├── advance/
    │   └── master/
    └── lessons/                       # Đánh giá cho cả lesson sau khi merge
        ├── begin/
        ├── advance/
        └── master/
```

### Bản đồ lưu file mẫu:

- Nếu tạo Section `L01_S01` thuộc level `begin`: ➔ Lưu vào:
  `output/sections/begin/L01_S01_khai-niem-ve-bien-va-gan-gia-tri.mdx`
- Nếu lưu review của Section `L01_S01` level `begin`: ➔ Lưu vào:
  `output/reviews/sections/begin/L01_S01_review.json`

- Nếu merge Lesson `L01` thuộc level `begin`: ➔ Lưu vào:
  `output/lessons/begin/L01_bien-va-kieu-du-lieu-co-ban.mdx`

- Nếu lưu review của Lesson `L01` level `begin`: ➔ Lưu vào:
  `output/reviews/lessons/begin/L01_review.json`
