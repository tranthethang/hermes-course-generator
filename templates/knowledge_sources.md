# Knowledge Sources & References

Khi sinh nội dung khóa học cho bất kỳ ngôn ngữ/công nghệ nào, AI Agent **BẮT BUỘC** phải ưu tiên sử
dụng các tài liệu chuẩn mực từ trang chủ của công nghệ đó. Không sử dụng các nguồn không chính thống
(như W3Schools, blog cá nhân) làm tài liệu tham khảo chính.

## SQL (Standard & Relational Databases)

- **Chuẩn SQL:** ISO/IEC 9075
- **PostgreSQL:** [PostgreSQL Documentation](https://www.postgresql.org/docs/) (Ưu tiên làm chuẩn
  cho ANSI SQL hiện đại)
- **MySQL:** [MySQL Reference Manual](https://dev.mysql.com/doc/)

**Lưu ý:** Nếu khóa học là SQL chung, sử dụng PostgreSQL làm hệ quản trị cơ sở dữ liệu mẫu cho các
ví dụ.

## MongoDB (NoSQL Document Database)

- **Trang chủ:** [MongoDB Documentation](https://www.mongodb.com/docs/)
- **Lưu ý:**
  - Không nhầm lẫn giữa MongoDB Shell command và các thư viện ORM/ODM (ví dụ: Mongoose). Code
    example trong bài học phải là query gốc trừ khi bài học có chủ đích dạy về ORM/ODM.
  - Luôn tham khảo tài liệu của phiên bản MongoDB mới nhất (hiện tại >= 6.0).

## Các ngôn ngữ khác (C#, Java, Go, Rust, Python,...)

- Luôn tìm kiếm "Official Documentation" của ngôn ngữ/framework đó.
- Ví dụ:
  - C#: [Microsoft Learn (.NET/C#)](https://learn.microsoft.com/en-us/dotnet/csharp/)
  - Go: [The Go Programming Language](https://go.dev/doc/)
  - Rust: [The Rust Programming Language (The Book)](https://doc.rust-lang.org/book/)
  - Python: [Python Documentation](https://docs.python.org/)

## Cách tích hợp vào bài giảng

- Tại cuối mỗi bài giảng hoặc các concept khó, cung cấp phần "Tài Liệu Tham Khảo" trỏ trực tiếp đến
  URL của Official Docs.
- Đảm bảo syntax trong code example khớp 100% với tài liệu chính thống.
