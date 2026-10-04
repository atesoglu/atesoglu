# Architecture and System Design

Notes on architecture, boundaries, distributed systems, and system design decisions.

## Loosely Coupled Monolith

These documents are complementary source notes rather than duplicates:

- [Creating a Loosely Coupled Monolith](creating-loosely-coupled-monolith.md) - Original conceptual transcript covering asynchronous messaging, bounded contexts, and strict boundaries.
- [Loosely Coupled Monolith Structure](loosely-coupled-monolith-structure.md) - Concrete .NET project and solution structure using contracts, implementations, tests, an API host, and a worker.
- [Loosely Coupled Monolith (2025 Edition)](loosely-coupled-monolith-2025.md) - Later update focused on cohesion, coupling, and the distinction between logical and physical boundaries.

All three are transcripts or source-derived notes. Treat them as reference material rather than as a single canonical architecture prescription.

## Other Topics

- [Resilience and Stability Patterns](resiliency-and-stability-patterns.md)
- [Service Boundaries and Splitting Entities](service-boundaries-splitting-entities.md)
- [System Design Principles](system-design-principles.md)
- [Thin vs Fat Events](thin-vs-fat-events.md)
- [Transaction Script vs DDD](transaction-script-vs-ddd.md)
- [Tracy](tracy-overview.md) - Overview, anomaly detection, implementation, and tracing tools.
