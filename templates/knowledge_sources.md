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

## Rust

For a Rust course, prioritize sources in this order:

- **Primary (beginner to advanced):**
  [The Rust Programming Language (The Book)](https://doc.rust-lang.org/book/)
- **Language reference:** [The Rust Reference](https://doc.rust-lang.org/reference/)
- **Standard library:** [std documentation](https://doc.rust-lang.org/std/)
- **Unsafe Rust internals:** [The Rustonomicon](https://doc.rust-lang.org/nomicon/)
- **Async programming:** [Asynchronous Programming in Rust](https://rust-lang.github.io/async-book/)
- **Macros (declarative and procedural):**
  [The Little Book of Rust Macros](https://veykril.github.io/tlborm/)
- **WebAssembly integration:**
  [The wasm-bindgen Guide](https://rustwasm.github.io/docs/wasm-bindgen/)
- **Cargo and package management:** [The Cargo Book](https://doc.rust-lang.org/cargo/)
- **Edition migration:** [Rust Edition Guide](https://doc.rust-lang.org/edition-guide/)
- **Performance patterns:** [Rust Performance Book](https://nnethercote.github.io/perf-book/)
- **API design guidelines:** [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/)
- **Error handling patterns:** [thiserror](https://docs.rs/thiserror) and
  [anyhow](https://docs.rs/anyhow)
- **Changelogs:** [Rust Release Notes](https://github.com/rust-lang/rust/blob/master/RELEASES.md)

## Python

- **Primary:** [Python Documentation](https://docs.python.org/) (version-specific)
- **Style guide:** [PEP 8 - Style Guide for Python Code](https://peps.python.org/pep-0008/)
- **Type hints:** [PEP 484](https://peps.python.org/pep-0484/) and
  [typing module docs](https://docs.python.org/3/library/typing.html)
- **Language proposals:** [Python Enhancement Proposals (PEPs)](https://peps.python.org/)
- **Standard library:** [Python Standard Library](https://docs.python.org/3/library/index.html)
- **Async:** [asyncio documentation](https://docs.python.org/3/library/asyncio.html)

## Go

- **Primary:** [The Go Programming Language](https://go.dev/doc/)
- **Standard library:** [Go Standard Library](https://pkg.go.dev/std)
- **Specification:** [The Go Programming Language Specification](https://go.dev/ref/spec)
- **Style:** [Effective Go](https://go.dev/doc/effective_go)
- **Module system:** [Go Modules Reference](https://go.dev/ref/mod)

## JavaScript and TypeScript

- **JavaScript:**
  [MDN Web Docs - JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- **TypeScript:** [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- **ECMAScript specification:** [ECMAScript Language Specification](https://tc39.es/ecma262/)

## Node.js

- **Official site:** [Node.js Documentation](https://nodejs.org/en/docs/)
- **API Reference:** [Node.js API Reference](https://nodejs.org/docs/latest/api/)
- **Guides:** [Node.js Guides](https://nodejs.org/en/learn/)
- **Security:**
  [Node.js Security Best Practices](https://nodejs.org/en/learn/getting-started/security-best-practices)
- **Package Manager:** [npm Documentation](https://docs.npmjs.com/)
- **Runtime V8 Engine:** [V8 Docs](https://v8.dev/docs)

## React and Next.js

- **React:**
  - **Official site:** [React Documentation](https://react.dev/)
  - **API Reference:** [React API Reference](https://react.dev/reference/react)
  - **Hooks:** [React Built-in Hooks](https://react.dev/reference/react/hooks)
  - **React Server Components:**
    [React Server Components Specification](https://react.dev/reference/rsc/server-components)
- **Next.js:**
  - **Official site:** [Next.js Documentation](https://nextjs.org/docs)
  - **App Router:** [Next.js App Router Guide](https://nextjs.org/docs/app)
  - **Pages Router:** [Next.js Pages Router Guide](https://nextjs.org/docs/pages)
  - **API Reference:** [Next.js API Reference](https://nextjs.org/docs/app/api-reference)
  - **Deployment:**
    [Next.js Deployment Guide](https://nextjs.org/docs/app/building-your-application/deploying)

## Vue and Nuxt.js

- **Vue.js:**
  - **Official site:** [Vue.js 3 Docs](https://vuejs.org/guide/introduction.html)
  - **API Reference:** [Vue.js API Reference](https://vuejs.org/api/)
  - **Composition API:**
    [Vue Composition API FAQ](https://vuejs.org/guide/extras/composition-api-faq.html)
  - **Vue Router:** [Vue Router Documentation](https://router.vuejs.org/)
  - **Pinia State Management:** [Pinia Documentation](https://pinia.vuejs.org/)
- **Nuxt.js:**
  - **Official site:** [Nuxt Documentation](https://nuxt.com/)
  - **Routing & Structure:**
    [Nuxt Directory Structure and Routing](https://nuxt.com/docs/getting-started/routing)
  - **API Reference:** [Nuxt API Docs](https://nuxt.com/docs/api)
  - **Modules:** [Nuxt Modules Directory](https://nuxt.com/modules)

## Java

- **Primary:** [Java SE Documentation](https://docs.oracle.com/en/java/javase/)
- **Standard library:** [Java API Reference](https://docs.oracle.com/en/java/javase/21/docs/api/)
- **Language specification:**
  [The Java Language Specification](https://docs.oracle.com/javase/specs/)

## C and C++

- **C:** [C reference - cppreference.com](https://en.cppreference.com/w/c)
- **C++:** [C++ reference - cppreference.com](https://en.cppreference.com/w/)
- **C++ standard:** [ISO C++ Standards](https://isocpp.org/std/the-standard)

## C#

- **Primary:**
  [Microsoft Learn - C# Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/)
- **Standard library:** [.NET API Browser](https://learn.microsoft.com/en-us/dotnet/api/)
- **Language specification:**
  [C# Language Specification](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/language-specification/)

---

## How to Integrate into Lessons

- At the end of each section, include a `## References` heading with direct links to the specific
  official documentation page for the topics covered, not just the homepage.
- For advance and master level sections, include secondary sources (RFCs, language specs, internal
  architecture docs) in addition to the primary tutorial-style source.
- Ensure the syntax in code examples matches the official documentation for the specified version.
- If a feature is version-specific (e.g., introduced in Rust 1.65 or Python 3.12), state the minimum
  version clearly in the section frontmatter and in the first code block comment.
