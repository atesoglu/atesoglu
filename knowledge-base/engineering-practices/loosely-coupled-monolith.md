# Loosely Coupled Monolith

A loosely coupled monolith is a single solution organized around strict bounded contexts and asynchronous messaging. The goal is to avoid both a big ball of mud and an unnecessary jump to microservices.

## Core Idea

- Define clear boundaries for each part of the system. The term **bounded context** comes from domain-driven design, but the practical point is to decide what belongs together and what must stay independent.
- Use asynchronous messaging between bounded contexts rather than direct synchronous calls.
- Organize each bounded context with separate contracts, implementation, and tests.
- Keep the system deployable as a monolith while preserving the option to split physical deployment artifacts later.
- Treat boundaries as a design decision, not a deployment topology decision.

## 2025 Update

The later edition reinforces three points:

- **Cohesion:** Keep related behavior together.
- **Coupling:** Manage dependencies deliberately rather than assuming a monolith means tight coupling.
- **Logical vs. physical boundaries:** Modules and projects are logical boundaries; they do not have to become separate deployables. A single codebase can still produce multiple deployment artifacts, such as an HTTP API host and a background worker.

## .NET Structure

- Use a top-level ASP.NET Core host for the HTTP API.
- Use a worker or message processor for messages from the message broker.
- Give each bounded context its own set of projects:
  - **Contracts:** Messages and interfaces shared with other contexts.
  - **Implementation:** Domain and application logic.
  - **Tests:** Tests for that context.
- Give each bounded context its own database rather than sharing one database schema across contexts.

## When to Split Deployment

The monolith can remain a single deployable for a long time. Split out a separate process or deployment artifact when there is a concrete operational reason, such as different scaling needs, isolation requirements, or a background workload that should not compete with the API.

## Source Notes

### Creating a Loosely Coupled Monolith

**Source:** [Creating a Loosely Coupled Monolith](https://www.youtube.com/watch?v=48C-RsEu0BQ) — CodeOpinion.

> Not every system needs microservices. Often it is better to create a monolith driven by asynchronous messaging and strict boundaries. The key point is having boundaries. A bounded context is about defining the boundaries of a particular part of the system.

### Loosely Coupled Monolith — 2025 Edition

**Source:** [Loosely Coupled Monolith — Software Architecture — 2025 Edition](https://www.youtube.com/watch?v=GOIYREEANEM) — CodeOpinion.

> The 2025 edition focuses on cohesion, managing coupling, and realizing that logical boundaries are not physical boundaries.

### Solution and Project Structure

**Source:** [Solution & Project Structure of a Loosely Coupled Monolith](https://www.youtube.com/watch?v=-1DU9c95ERs) — CodeOpinion.

> The structure has two top-level processes: an ASP.NET Core HTTP server and a message processor. Below them are bounded contexts, each with contracts, implementation, and tests, and each with its own database.
