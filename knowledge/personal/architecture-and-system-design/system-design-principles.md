# System Design Principles

**Summary:** A checklist for requirements, scale, performance, cost and the key stages in designing large systems.

## Requirement Clarifications

- Users/Clients: Who will use the system? How will the system be used?
- Scale: How many reads per second? Is there more write than read? Can there be spikes in traffic?
- Performance: Expected write-to-read data delay? Expected p99 latency for reads?
- Cost: Cost of development or cost of maintenance?

## System Design Components

1. Define the Problem Space: Understand the problem and define scope; clarify functional and non-functional requirements.
2. Design the System at a High Level: APIs, communication patterns, high-level diagram.
3. Deep Dive into the Design: Component relationships, non-functional requirements, trade-offs.
4. Identify Bottlenecks and Scaling Opportunities: Single points of failure, replication, sharding, CDN, caching.
5. Review and Wrap Up: Summarize decisions with trade-offs.

## The CAP Theorem
Consistency, Availability and Partition Tolerance — a system cannot provide all three guarantees simultaneously.

