# System Design Playbook

> **Golden Rule — Clarify these three things first:**
> * **What are we building?** (Scope and core functionality)
> * **How big will it be?** (Users, traffic, and data volume)
> * **What matters most?** (Performance, availability, security, or cost)
>
> *These answers will guide almost every major system design decision.*

---

## Step 1: Define the Problem Space & Clarify Requirements
*Understand the problem, lock down the scope, and state assumptions explicitly.*

### 1.1 Functional Requirements (What should the system do?)
1. **Users & Clients:** Who are the users/clients, how will they access the system, and what can each user do?
2. **Core Features:** What are the main features and capabilities of the system?
3. **Key Workflows:** What are the most important user workflows or use cases?
4. **Data Operations:** What data should the system store, retrieve, update, or delete?
5. **Integrations:** What external systems or APIs should it integrate with?
6. **Edge Cases:** What should happen when something goes wrong (e.g., failed requests)?

### 1.2 Non-Functional Requirements (How should the system perform?)
1. **Scale & Traffic:**
   * How many total users and requests per second (RPS) should the system support?
   * What is the read-to-write ratio (read-heavy vs. write-heavy)?
   * Can there be sudden spikes in traffic?
2. **Performance & Latency:**
   * What are the expected response times (e.g., p99 latency for reads)?
   * What is the acceptable write-to-read data propagation delay?
3. **Availability:** What uptime is required (e.g., 99.9% vs. 99.99%)?
4. **Consistency:** How consistent must the data be across the system (strong vs. eventual consistency)?
5. **Reliability:** How should the system handle failures and recover?
6. **Security & Compliance:**
   * How will authentication, authorization, and data protection work?
   * Are there legal or regulatory requirements (e.g., GDPR)?
7. **Maintainability:** How easy should it be to update and extend the system?
8. **Cost:** What are the budget constraints for development and ongoing maintenance?

---

## Step 2: Back-of-the-Envelope Estimations
*Calculate rough capacity numbers to validate architectural choices before designing.*

### 2.1 Core Formulas
- **Write QPS (Queries Per Second):** `Daily Active Users (DAU) × avg writes per user ÷ 86,400` *(rule of thumb: 10⁵ seconds/day)*
- **Read QPS (Queries Per Second):** `Write QPS × read-to-write ratio`
- **Peak QPS (Queries Per Second):** `Average QPS × 2 to 3` *(adjust higher for bursty traffic)*
- **Storage:** `Daily new records × avg record size × 365 × retention years`
- **Bandwidth:** `QPS × avg payload size`

### 2.2 Handy Reference Numbers
- **Time & Scale:**
  * 1 day = 86,400 seconds ≈ 10⁵ seconds
  * 1 million requests/day ≈ 12 QPS (Queries Per Second)
  * 100 million requests/day ≈ 1,200 QPS (Queries Per Second)
- **Data Sizes:**
  * `char` / ASCII: 1 byte | Unicode: 2–4 bytes
  * `int64` / Timestamp / UUID (Universally Unique Identifier): 8–16 bytes
  * Typical JSON metadata record: 500 bytes – 1 KB (Kilobyte)
  * Compressed thumbnail / image: 50 KB – 500 KB (Kilobytes)
- **Latency Benchmarks:**
  * L1 / L2 cache reference: ~1 – 10 ns (nanoseconds)
  * RAM read: ~100 ns (nanoseconds)
  * Redis / Memcached network round-trip: ~0.5 – 1 ms (milliseconds)
  * SSD random read: ~100 µs (microseconds) – 1 ms (millisecond)
  * Disk seek (HDD): ~10 ms (milliseconds)
  * Cross-continent network round-trip (e.g., US ↔ Europe): ~80 – 150 ms (milliseconds)

---

## Step 3: Design the System at a High Level
*Establish the core contract and data flow before diving into infrastructure.*

- **API Design:** Define how clients access system resources (endpoints, request parameters, response types, and communication protocols like REST, GraphQL, or gRPC).
- **Data Model / Schema:** Identify core entities and high-level storage needs based on Step 2 estimates.
- **High-Level Architecture Diagram:** Map out the end-to-end flow from client to backend services and databases.

---

## Step 4: Deep Dive into the Design
*Zoom in on critical components and justify architectural trade-offs.*

- **Component Relationships:** Examine core services, databases, queues, and workers in detail.
- **Requirement-Driven Choices:** Map your design directly back to the non-functional requirements (e.g., choosing SQL vs. NoSQL based on consistency and scale).
- **Trade-Off Analysis:** Present alternative design options with clear pros and cons (refer to the **Consistency, Availability & Latency Cheat Sheet** below when justifying storage and replication trade-offs).

---

## Step 5: Identify Bottlenecks & Scaling Opportunities
*Stress-test your architecture under heavy load and failure scenarios.*

- **Eliminate Single Points of Failure (SPOFs):** Introduce redundancy, failover mechanisms, and multi-region/global service support.
- **Database Scaling:** Evaluate data replication, partitioning, and horizontal sharding.
- **Traffic & Read Optimization:** Implement caching layers, CDNs for static/edge content, and load balancing.
- **System Protection:** Add rate limiting, backpressure, and circuit breakers to handle traffic spikes gracefully.

---

## Step 6: Review & Wrap Up
*Close the session by tying the architecture back to the initial goals.*

- **Decision Summary:** Recap major architectural decisions alongside their justifications and trade-offs.
- **Requirement Check:** Verify that every functional and non-functional requirement from Step 1 is satisfied.
- **Future Improvements:** Identify next steps if given more time or higher scale targets (e.g., observability, analytics, ML pipelines).

---

## Quick Reference: Consistency, Availability & Latency (CAP / PACELC)

In distributed systems, network partitions (**P**) are inevitable—you cannot choose "CA." Use **PACELC** to frame trade-offs clearly during Step 4:
- **If a Partition occurs (P):** Choose **A**vailability (serve requests, risk stale data) or **C**onsistency (reject requests until nodes sync).
- **Else during normal operation (E):** Choose **L**atency (fast async replication) or **C**onsistency (slower sync replication across nodes).

### Practical Decision Matrix

| Priority Profile | PACELC Trade-Off | When to Use It (Examples) | Typical Tech Choices |
| :--- | :--- | :--- | :--- |
| **Strong Consistency First** | **PC / EC** *(Sacrifice availability & speed for accuracy)* | Financial ledgers, payment processing, inventory locks, ticket booking | PostgreSQL, MySQL, Spanner, CockroachDB |
| **High Availability & Low Latency** | **PA / EL** *(Accept eventual consistency for speed & uptime)* | Social media feeds, likes/view counters, user activity logs, shopping carts | Cassandra, DynamoDB (eventual), ScyllaDB |
| **Tunable / Hybrid** | **PA / EC** or **PC / EL** *(Balance per operation)* | E-commerce product catalogs (eventual reads, strong writes), session stores | DynamoDB (quorum reads), MongoDB, Redis Cluster |

### Soundbites for Live Sessions
- **Choosing CP (Strong Consistency):** *"Because double-booking or negative balances are unacceptable here, we must prioritize consistency over availability—rejecting writes if a partition isolates the primary node."*
- **Choosing AP / Low Latency (Eventual Consistency):** *"A user seeing a post or view count 2 seconds late has zero business impact, whereas downtime does—so we'll use asynchronous replication to keep read latency low and availability high."*
