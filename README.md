# Hermes Course Generator Toolset

[English version below]

Bộ công cụ **Hermes Course Generator** hỗ trợ tự động hóa việc thiết lập và tạo các khóa học lập
trình (như Rust, C#, Go, Java, Python,...) tích hợp với quy trình làm việc của AI Agent (Hermes
Workflow) và định dạng tài liệu tương thích Docusaurus.

## Tính năng chính

- **Cấu trúc Thư mục Chuẩn**: Tự động sinh ra cấu trúc thư mục đầu ra phân cấp theo cấp độ (`begin`,
  `advance`, `master`) cho các bài học, chương, và đánh giá.
- **Quản lý Trạng thái**: Theo dõi tiến độ biên soạn khóa học thông qua file `state.md`.
- **Hỗ trợ Agent / Skills**: Định nghĩa Skill giúp AI Agent hiểu và thực hiện quy trình phỏng vấn
  tương tác để thiết lập khóa học mới.

---

## Hướng dẫn sử dụng (Tiếng Việt)

### 1. Cài đặt

Để cài đặt nhanh công cụ CLI và các template mẫu trực tiếp mà không cần clone repo:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/install.sh | bash
```

Hoặc nếu bạn đã clone repo về thư mục cục bộ, hãy chạy:

```bash
./install.sh
```

_Lưu ý: Hãy đảm bảo rằng thư mục `~/.local/bin` đã được cấu hình trong biến môi trường `PATH` của
bạn (ví dụ trong file `.zshrc` hoặc `.bashrc`)._

### 2. Xác minh cài đặt

Kiểm tra xem bộ công cụ đã được cài đặt và cấu hình chính xác chưa:

```bash
./verify.sh
```

### 3. Khởi tạo một Workspace mới

Để bắt đầu một khóa học mới, di chuyển đến thư mục mong muốn và chạy:

```bash
hermes-course-generator init
```

Hoặc chỉ định đường dẫn cụ thể:

```bash
hermes-course-generator init --path /path/to/new-course
```

### 4. Định dạng tài liệu

Để tự động định dạng (format) tất cả các tài liệu markdown `.md` trong dự án sử dụng Prettier:

```bash
./format.sh
```

### 5. Gỡ cài đặt

Để gỡ cài đặt nhanh trực tiếp:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/uninstall.sh | bash
```

Hoặc chạy script cục bộ:

```bash
./uninstall.sh
```

### 6. Prompt mẫu để kích hoạt AI Agent

Bạn có thể sao chép prompt sau và gửi cho AI Agent để bắt đầu tạo khóa học mới:

> _"Tôi muốn bắt đầu thiết lập một khóa học mới cho ngôn ngữ lập trình [Rust/Python/Go]. Hãy sử dụng
> skill `hermes-course-generator` và tiến hành phỏng vấn tôi để lấy các thông số cần thiết."_

---

## User Guide (English)

The **Hermes Course Generator** toolset automates the initialization and generation of programming
courses (such as Rust, C#, Go, Java, Python, etc.) integrated with AI Agent workflows (Hermes
Workflow) and Docusaurus-compatible documentation.

## Key Features

- **Standard Directory Structure**: Automatically generates folder structures grouped by levels
  (`begin`, `advance`, `master`) for sections, lessons, and reviews.
- **State Management**: Tracks course compilation progress through a centralized `state.md` file.
- **Agent Skill Integration**: Defines a global skill so AI Agents understand how to conduct
  interactive interviews to set up new courses.

---

### 1. Installation

To install the CLI tool and register global configurations directly without cloning the repo, run:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/install.sh | bash
```

Or run locally if you have cloned the repository:

```bash
./install.sh
```

_Note: Please ensure that `~/.local/bin` is added to your environment `PATH` variable (e.g. in your
`.zshrc` or `.bashrc`)._

### 2. Verification

To verify that everything has been installed and configured correctly:

```bash
./verify.sh
```

### 3. Initialize a New Workspace

To start a new course, navigate to your desired directory and run:

```bash
hermes-course-generator init
```

Or specify a custom path:

```bash
hermes-course-generator init --path /path/to/new-course
```

### 4. Document Formatting

To automatically format all markdown `.md` files in the repository using Prettier:

```bash
./format.sh
```

### 5. Uninstallation

To completely remove the toolset and global templates directly, run:

```bash
curl -fsSL https://raw.githubusercontent.com/tranthethang/hermes-course-generator/main/uninstall.sh | bash
```

Or run the local script:

```bash
./uninstall.sh
```

### 6. Sample Prompt to Trigger AI Agent

Copy and send the following prompt to your AI Agent to begin:

> _"I want to set up a new course for [Rust/Python/Go]. Please use the `hermes-course-generator`
> skill and interview me to collect the required settings."_

---

## Cấu trúc thư mục dự án / Repository Structure

- [bin/](file:///Users/thangtt/Documents/Github/hermes-course-generator/bin): Chứa mã nguồn CLI tool
  bằng Python (`hermes-course-generator`).
- [skills/](file:///Users/thangtt/Documents/Github/hermes-course-generator/skills): Định nghĩa file
  Skill cho các AI Agent (`SKILL.md`).
- [templates/](file:///Users/thangtt/Documents/Github/hermes-course-generator/templates): Chứa các
  tài liệu hướng dẫn mẫu toàn cục (Global templates).
- [install.sh](file:///Users/thangtt/Documents/Github/hermes-course-generator/install.sh): Script
  cài đặt / Installation script.
- [verify.sh](file:///Users/thangtt/Documents/Github/hermes-course-generator/verify.sh): Script xác
  minh / Verification script.
- [format.sh](file:///Users/thangtt/Documents/Github/hermes-course-generator/format.sh): Script định
  dạng tài liệu / Formatting script.
- [uninstall.sh](file:///Users/thangtt/Documents/Github/hermes-course-generator/uninstall.sh):
  Script gỡ bỏ / Uninstallation script.
