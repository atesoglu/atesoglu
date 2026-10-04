# This critique is ultimately narrow and misses the core thesis of the article.

*I'll call it, the title of this article a great conceptual hook, though technically slightly inverted from a language-evolution perspectve…*

This critique is ultimately narrow and misses the core thesis of the article. You're evaluating the comparison through an infra/runtime lens rather than a development-ergonomics lens, whereas this article is all about developer ergonomics.

I'll call it, the title of this article a great conceptual hook, though technically slightly inverted from a language-evolution perspectve since F# was released around 2005 and heavily influenced the design of modern Rust.

You're right about different target domains and runtimes, binary sizes and standalone executables but saying F# is definitely not safe is factually incorrect. F#'s type system prevents null reference exceptions via Option<T>, resource leaks via IDisposable usage and state corruption via default immutability and strict type inference. In fact, F# code running on the CLR is memory-safe precisely because the managed runtime prevents buffer overflows, dangling pointers and double-frees automatically.

Second thing is, saying "syntax similarity is completely irrelevant" dismisses the language design. It's not just cosmetic, it directly shapes how devs model domain logic. Any dev writing domain models in Rust, thinks in almost the exact same mental patterns as an F# developer.

This article isn't claiming F# is a systems programming language or that F# should replace Rust or F# is better etc. It argues that for application-level logic, devs who love Rust for its type system, ergonomics, safety guarantees and correctness will find the same paradigm and joy in F# when operating in a managed/enterprise environment.

From many perspectives, F# and Rust are very close cousins. Dismissing that alignment as "misleading" ignores why modern devs choose languages in the first place.