## Questions to ask in an interview
- What are the team's main technical challenges over the next 12–18 months?
- How much ownership will I have over architecture and technical direction?
- How does the team balance new product development with operational support?
- What does success look like after six months?

---

## From C# Instincts to Go-Oriented Practices

| Familiar C# Instinct                                 | Go-Oriented Approach to Practice                                                                       |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| Create interfaces for most dependencies              | Define small interfaces where they establish a meaningful boundary, often at the point of consumption. |
| Build a generic repository/service framework         | Prefer straightforward types and functions until reuse or complexity justifies abstraction.            |
| Reach for exceptions                                 | Return and handle errors explicitly.                                                                   |
| Treat asynchronous execution as a framework concern  | Understand goroutine lifecycles, cancellation, synchronization, and ownership.                         |
| Optimize based on intuition                          | Benchmark and profile before changing the implementation.                                              |
| Introduce abstractions for hypothetical future needs | Start simple and evolve the design as concrete requirements emerge.                                    |
