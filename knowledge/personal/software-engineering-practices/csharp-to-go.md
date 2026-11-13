# From C# Instincts to Go-Oriented Practices

**Summary:** A quick translation guide for engineers moving from C# habits to idiomatic Go.

| Familiar C# Instinct | Go-Oriented Approach to Practice |
| --- | --- |
| Create interfaces for most dependencies | Define small interfaces where they establish a meaningful boundary, often at the point of consumption. |
| Build a generic repository/service framework | Prefer straightforward types and functions until reuse or complexity justifies abstraction. |
| Reach for exceptions | Return and handle errors explicitly. |
| Treat asynchronous execution as a framework concern | Understand goroutine lifecycles, cancellation, synchronization, and ownership. |
| Optimize based on intuition | Benchmark and profile before changing the implementation. |
| Introduce abstractions for hypothetical future needs | Start simple and evolve the design as concrete requirements emerge. |
