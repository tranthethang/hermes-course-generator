# Knowledge Sources & References

When generating course content for any language/technology, the AI Agent **MUST** prioritize using
standard documentation from the official site of that technology. Do not use unofficial sources
(such as W3Schools, personal blogs) as primary references.

## SQL (Standard & Relational Databases)

- **SQL Standard:** ISO/IEC 9075
- **PostgreSQL:** [PostgreSQL Documentation](https://www.postgresql.org/docs/) (Preferred standard
  for modern ANSI SQL)
- **MySQL:** [MySQL Reference Manual](https://dev.mysql.com/doc/)

**Note:** If the course is about general SQL, use PostgreSQL as the reference database management
system for examples.

## MongoDB (NoSQL Document Database)

- **Official site:** [MongoDB Documentation](https://www.mongodb.com/docs/)
- **Notes:**
  - Do not confuse MongoDB Shell commands with ORM/ODM libraries (e.g., Mongoose). Code examples in
    lessons must use native queries unless the lesson specifically intends to teach ORM/ODM.
  - Always refer to the latest MongoDB version documentation (currently >= 6.0).

## Other Languages (C#, Java, Go, Rust, Python,...)

- Always search for the "Official Documentation" of the language/framework.
- Examples:
  - C#: [Microsoft Learn (.NET/C#)](https://learn.microsoft.com/en-us/dotnet/csharp/)
  - Go: [The Go Programming Language](https://go.dev/doc/)
  - Rust: [The Rust Programming Language (The Book)](https://doc.rust-lang.org/book/)
  - Python: [Python Documentation](https://docs.python.org/)

## How to Integrate into Lessons

- At the end of each lesson or difficult concept, provide a "References" section pointing directly
  to the official docs URL.
- Ensure the syntax in code examples matches the official documentation 100%.
