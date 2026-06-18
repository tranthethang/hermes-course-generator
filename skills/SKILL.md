---
name: hermes-course-generator
description: >-
  Khởi tạo cấu trúc dự án và tạo giáo trình (syllabus), tài liệu hướng dẫn khóa học lập trình bất kỳ (Rust, C#, Java, Go, v.v.) tương thích Docusaurus.
---

# Hermes Course Generator Skill

## Overview

Skill này hướng dẫn Agent tương tác với người dùng để thiết lập một môi trường tạo khóa học tự động cho bất kỳ ngôn ngữ lập trình nào, tương thích hoàn toàn với Docusaurus MDX.

## Dependencies

- Công cụ CLI `hermes-course-generator` được cài đặt tại `/Users/thangtt/.local/bin/hermes-course-generator`.

## Quick Start

Khi người dùng yêu cầu: _"Tôi muốn tạo khóa học [Rust/C#/Go...]"_ hoặc _"Hãy setup khóa học lập trình mới"_, Agent sẽ kích hoạt quy trình thiết lập tương tác.

## Workflow

### Bước 1: Thu Thập Yêu Cầu (Interactive Interview)

Agent hỏi các thông số:

1. Ngôn ngữ lập trình mong muốn
2. Cấp độ giảng dạy (begin, advance, master)
3. Đối tượng học viên
4. Quy mô khóa học (Số lượng Lessons & Sections)

### Bước 2: Khởi Tạo Môi Trường Bằng CLI

Agent chạy lệnh CLI để tạo khung thư mục:
`hermes-course-generator init --path <đường_dẫn_dự_án>`

### Bước 3: Tự Động Sinh Nội Dung Cấu Thiết Lập (Dynamic Generation)

Agent tự động tạo ra 3 tài liệu cốt lõi cá nhân hóa cho ngôn ngữ đã chọn:

- `overview.md`: Mục tiêu đầu ra chi tiết của ngôn ngữ.
- `architecture.md` (Giáo trình Syllabus): Lập danh sách chi tiết các Lessons và Sections phù hợp đặc trưng ngôn ngữ.
- `style_guide.md`: Quy chuẩn viết code của ngôn ngữ và tích hợp quy tắc an toàn MDX (tránh viết các generic dạng `<T>`, `<string>` trần trụi ngoài text, phải bọc trong inline code).

### Bước 4: Thiết Lập Trạng Thế

Cập nhật file `state.md` ghi nhận danh sách toàn bộ các section và lesson, đặt trạng thái ban đầu:

```yaml
status: init
completed_sections: []
```

### Bước 5: Báo Cáo Hoàn Thành

Trình bày cấu trúc khóa học đã tạo (`architecture.md`) cho người dùng và hướng dẫn họ cách bắt đầu quy trình Hermes Workflow tiếp theo.
