# Style Guide

> **Dành cho:** Hermes AI Agent  
> **Mục đích:** Quy tắc văn phong tiếng Việt, cách trình bày code, và hướng dẫn viết nội dung khóa
> học.

---

## 1. Văn Phong Tiếng Việt

### 1.1 Nguyên Tắc Chung

| Nguyên tắc                      | Mô tả                                                       |
| ------------------------------- | ----------------------------------------------------------- |
| **Thân thiện, không cứng nhắc** | Viết như đang hướng dẫn trực tiếp, không như sách giáo khoa |
| **Chuyên nghiệp**               | Tránh từ lóng, biệt ngữ không cần thiết                     |
| **Rõ ràng hơn là văn hoa**      | Câu ngắn, ý rõ, tránh câu dài lòng vòng                     |
| **Chủ động**                    | Dùng "bạn sẽ học", không dùng "người học được hướng dẫn"    |

### 1.2 Xưng Hô

- Gọi người đọc là **"bạn"** (không phải "các bạn", "quý vị", "học viên").
- Hermes tự xưng là **"chúng ta"** khi giải thích cùng nhau, không dùng "tôi".
- Ví dụ: "Chúng ta sẽ cùng tìm hiểu..." thay vì "Tôi sẽ giải thích..."

### 1.3 Cấu Trúc Câu

**Ưu tiên:**

- Câu ngắn, tối đa 20–25 từ mỗi câu.
- Mỗi đoạn văn: 3–5 câu.
- Bắt đầu bằng khái niệm, kết thúc bằng ví dụ hoặc hành động.

**Tránh:**

- Câu bị động: ❌ "Biến được dùng để lưu trữ..." → ✅ "Biến lưu trữ..."
- Câu dài có nhiều mệnh đề: ❌ "[Tên Ngôn Ngữ] là ngôn ngữ lập trình mạnh mẽ, linh hoạt, dễ học,
  được dùng rộng rãi..."
- Từ thừa: ❌ "Thực ra thì..." "Về cơ bản thì..." "Nói một cách đơn giản..."

### 1.4 Ví Dụ Văn Phong

**❌ Không viết như thế này:**

> "[Kiểu dữ liệu] là một kiểu dữ liệu trong [Tên Ngôn Ngữ] cho phép lưu trữ các phần tử..."

**✅ Viết như thế này:**

> "List giống như một chiếc hộp chứa nhiều thứ khác nhau. Bạn có thể bỏ vào số, chuỗi, thậm chí là
> một list khác. Và bạn có thể thay đổi nội dung của hộp bất cứ lúc nào."

---

## 2. Cách Dùng Thuật Ngữ Tiếng Anh

### 2.1 Quy Tắc Giữ Nguyên Tiếng Anh

Giữ nguyên tiếng Anh cho các thuật ngữ sau (KHÔNG dịch):

- Tên ngôn ngữ lập trình: `Python`, `JavaScript`, `SQL`, `Rust`, `Go`, `C#`
- Tên kiểu dữ liệu đặc thù (Ví dụ: `list`, `dict`, `vector`, `struct`, `class`, `int`, `float`)
- Tên từ khóa (Ví dụ: `for`, `while`, `if`, `fn`, `let`, `pub`, `def`, `return`, `import`)
- Tên hàm/method (Ví dụ: `print()`, `len()`, `append()`, `unwrap()`)
- Tên khái niệm kỹ thuật phổ biến: `function`, `variable`, `loop`, `recursion`, `decorator`,
  `generator`, `iterator`, `ownership`
- Tên các chuẩn/module/package đặc thù (Ví dụ: `PEP 8`, `Cargo.toml`, `std::collections`, `pathlib`)
- Tên lỗi/exceptions (Ví dụ: `ValueError`, `NullReferenceException`, `Panic`)

### 2.2 Thuật Ngữ Cần Giải Thích

Lần đầu xuất hiện trong section, dùng cả tiếng Anh lẫn tiếng Việt:

- "`closure` (hàm đóng)" — sau đó dùng `closure` thống nhất
- "`interface` (giao diện)" — sau đó dùng `interface` thống nhất
- "`decorator` (bộ trang trí)" — sau đó dùng `decorator` thống nhất

### 2.3 Thuật Ngữ Nên Dịch

| Tiếng Anh    | Dùng trong nội dung     |
| ------------ | ----------------------- |
| variable     | biến                    |
| function     | hàm                     |
| loop         | vòng lặp                |
| condition    | điều kiện               |
| exception    | ngoại lệ                |
| inheritance  | kế thừa                 |
| module       | module (giữ nguyên)     |
| class        | class (giữ nguyên)      |
| method       | method hoặc phương thức |
| argument     | đối số                  |
| parameter    | tham số                 |
| return value | giá trị trả về          |
| data type    | kiểu dữ liệu            |
| string       | chuỗi ký tự hoặc `str`  |
| integer      | số nguyên hoặc `int`    |

---

## 3. Cấu Trúc Trình Bày Khái Niệm

**Thứ tự bắt buộc:**

```
1. Giải thích "là gì" bằng ngôn ngữ tự nhiên
2. Dùng phép tương tự thực tế (nếu phù hợp)
3. Giải thích tại sao cần dùng
4. Đưa ra code ví dụ đơn giản nhất
5. Mở rộng với ví dụ thực tế hơn
6. Nêu trường hợp đặc biệt hoặc lỗi thường gặp
7. Nêu best practice
```

---

## 4. Quy Tắc Viết Code Sample

### 4.1 Tiêu Chuẩn Bắt Buộc (Ví dụ minh họa cho Python/SQL/MongoDB)

**Đối với ngôn ngữ lập trình (Ví dụ Python):**

```python
# Python 3.12+
# ✅ Luôn khai báo phiên bản ngôn ngữ ở đầu file hoặc đầu code block đầu tiên (nếu cần thiết)

# ✅ Sử dụng cú pháp chuẩn và hiện đại nhất của ngôn ngữ (ví dụ type hints)
def tinh_dien_tich(chieu_dai: float, chieu_rong: float) -> float:
    """Tính diện tích hình chữ nhật."""
    return chieu_dai * chieu_rong

# ✅ Tên biến bằng tiếng Việt không dấu hoặc tiếng Anh, nhất quán trong ví dụ
ten_hoc_sinh = "Nguyễn Văn A"  # Tên người dùng tiếng Việt
student_name = "Nguyen Van A"  # Hoặc tiếng Anh, chọn 1 cái và nhất quán

# ✅ Comment giải thích bằng tiếng Việt
danh_sach = [1, 2, 3, 4, 5]  # List chứa 5 số nguyên
```

**Đối với cơ sở dữ liệu (Ví dụ SQL):**

```sql
-- PostgreSQL 15+
-- ✅ Comment dòng bắt đầu bằng --
-- Lấy danh sách 5 nhân viên có lương cao nhất
SELECT
    first_name,
    last_name,
    salary
FROM employees
WHERE department = 'Engineering'
ORDER BY salary DESC
LIMIT 5;
```

**Đối với cơ sở dữ liệu (Ví dụ MongoDB):**

```javascript
// MongoDB 6.0+
// ✅ Comment giải thích mục đích query
// Tìm các user ở Việt Nam, được sắp xếp theo ngày đăng ký mới nhất
db.users
  .find({ country: "Vietnam" }, { username: 1, email: 1, registered_at: 1, _id: 0 })
  .sort({ registered_at: -1 })
  .limit(10);
```

### 4.2 Quy Tắc Comment

- Comment phải giải thích **tại sao**, không phải **cái gì** (code đã nói cái gì rồi).
- Mỗi ví dụ code cần ít nhất 2–3 comment.
- Dùng `#` cho inline comment, docstring `"""` cho function/class.

```python
# ❌ Comment vô nghĩa
x = x + 1  # Tăng x lên 1

# ✅ Comment có giá trị
x = x + 1  # Bù thêm 1 vì index bắt đầu từ 0
```

### 4.3 Format Code Block

Luôn khai báo ngôn ngữ tương ứng (ví dụ: `rust`, `python`, `go`):

````markdown
```{language}
// Code ở đây
```
````

Khi so sánh code sai và đúng (Ví dụ minh họa cho Python):

```python
# ❌ SAI
result = [x for x in range(10) if x % 2 = 0]  # SyntaxError

# ✅ ĐÚNG
result = [x for x in range(10) if x % 2 == 0]
```

### 4.4 Quy Tắc Đặt Tên & Định Dạng (Style Guide/Naming Conventions)

- Tuân thủ quy tắc đặt tên chuẩn của ngôn ngữ lập trình được dạy (ví dụ: `camelCase` cho
  Java/JavaScript; `snake_case` cho Python/Rust; `PascalCase` cho C#).
- Tên biến/hàm/bảng/cột: Tuân thủ chuẩn của ngôn ngữ (ví dụ: `snake_case` cho Python và bảng SQL).
- Tên class/struct/type: Thường là `PascalCase`.
- Tên hằng số: Thường là `UPPER_SNAKE_CASE` hoặc theo chuẩn ngôn ngữ.
- SQL Keywords: Bắt buộc viết IN HOA (`SELECT`, `FROM`, `WHERE`).
- Định dạng (Formatting): Sử dụng công cụ formatter chuẩn của ngôn ngữ để định dạng dòng và độ dài
  dòng. Với SQL, đảm bảo xuống dòng ở mỗi mệnh đề chính.

### 4.5 Code Phải Runnable

Mọi code block (đối với lập trình) phải có thể chạy được ngay lập tức. Nếu cần import/khai báo thư
viện ngoài, phải ghi rõ (Ví dụ minh họa cho Python):

```python
# Cần cài: pip install requests
import requests

response = requests.get("https://api.example.com/data")
print(response.status_code)
```

**Lưu ý:** Với SQL và MongoDB, chỉ yêu cầu độ chính xác về cú pháp (Syntax) theo tiêu chuẩn/tài liệu
của HQTCSDL đó, không bắt buộc môi trường để chạy thực tế trong bước review.

---

## 5. Quy Tắc Viết Ví Dụ

### 5.1 Ví Dụ Phải Thực Tế

| ❌ Tránh                         | ✅ Nên dùng                                         |
| -------------------------------- | --------------------------------------------------- |
| `foo`, `bar`, `baz` làm tên biến | `student_scores`, `product_prices`                  |
| `x = 10` không ngữ cảnh          | `age = 25  # Tuổi của người dùng`                   |
| Khai báo hàm không rõ ràng       | Khai báo hàm có tên rõ nghĩa, kiểu dữ liệu (nếu có) |
| In `Hello World`                 | Xử lý dữ liệu thực tế (tên, điểm, giá...)           |

### 5.2 Độ Phức Tạp Tăng Dần

Trong một section, ví dụ phải từ đơn giản đến phức tạp:

```
Ví dụ 1: Trường hợp cơ bản nhất
Ví dụ 2: Thêm một tình huống thực tế
Ví dụ 3 (nếu có): Kết hợp với kiến thức khác hoặc edge case
```

---

## 6. Quy Tắc Viết Bài Tập

### 6.1 Cấu Trúc Bắt Buộc

```markdown
### Bài Tập: [Tên bài tập rõ ràng]

**Yêu cầu:** Mô tả cụ thể, không mơ hồ. Nêu rõ:

- Input là gì
- Output là gì
- Điều kiện đặc biệt (nếu có)

**Ví dụ:**

- Input: `[1, 2, 3, 4, 5]`
- Output: `[1, 4, 9, 16, 25]`

**Gợi ý (tùy chọn):**

- Sử dụng tính năng/phương thức đặc thù (Ví dụ: list comprehension trong Python, `map` trong Rust,
  LINQ trong C#)

**Mức độ:** Cơ bản / Nâng cao
```

### 6.2 Quy Tắc Bài Tập

- KHÔNG đưa lời giải ngay trong phần bài tập section.
- Bài tập phải kiểm tra ĐÚNG kiến thức vừa học trong section đó.
- Bài tập của lesson-level (trong phần Tổng Hợp) phải kết hợp nhiều section.

---

## 7. Quy Tắc Viết Quiz

````markdown
### Câu [N]: [Câu hỏi rõ ràng, không mơ hồ (Ví dụ minh họa cho Python)]

```python
# Code cho câu hỏi đọc code (nếu có)
x = [1, 2, 3]
print(x[-1])
```
````

- A) `1`
- B) `2`
- C) `3`
- D) `IndexError`

<details>
<summary>📖 Xem đáp án</summary>

**Đáp án: C) `3`**

Giải thích: Index `-1` trong Python trỏ đến phần tử cuối cùng của list. (Khi viết cho ngôn ngữ khác,
hãy dùng ví dụ và giải thích tương ứng).

</details>
```

Quiz rules:

- Câu hỏi phải có 4 đáp án rõ ràng.
- Chỉ có DUY NHẤT 1 đáp án đúng.
- Đáp án sai phải "hợp lý" – không được quá hiển nhiên là sai.
- Luôn có giải thích ngắn trong phần đáp án.

---

## 8. Quy Tắc Tương Thích Docusaurus & MDX

Khi viết tài liệu bài học, bắt buộc tuân thủ các quy tắc Docusaurus MDX để tránh lỗi trong quá trình
compile và hiển thị:

### 8.1 Tránh Lỗi MDX Safety (Ký tự `<` và `>`)

- Bộ phân tích MDX của Docusaurus sẽ hiểu nhầm các ký tự `<` và `>` đứng một mình (hoặc dạng tên
  kiểu dữ liệu như `<int>`, `<string>`, `<T>`) là các thẻ HTML/JSX chưa đóng. Điều này gây lỗi build
  hệ thống.
- **Quy tắc:** Bắt buộc bọc các ký tự này hoặc các kiểu generic vào trong inline code (ví dụ:
  `` `<string>` `` hoặc `` `<T>` ``) hoặc dùng ký tự escape (`\<int\>`).

### 8.2 Sử dụng Hộp Thông Tin (Admonitions)

Không sử dụng định dạng trích dẫn của Github (ví dụ: `> [!NOTE]`). Thay vào đó, hãy sử dụng
Docusaurus Admonitions với cú pháp:

```markdown
:::note Tên Tiêu Đề (Tùy chọn) Nội dung ghi chú ở đây. :::

:::tip Mẹo hữu ích Nội dung mẹo ở đây. :::

:::info Thông tin Nội dung thông tin ở đây. :::

:::warning Cảnh báo Nội dung cảnh báo ở đây. :::

:::danger Nguy hiểm Nội dung lỗi nghiêm trọng/nguy hiểm ở đây. :::
```
