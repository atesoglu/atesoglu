# Boundaries, Events, and Domain Modeling

Notes on deciding where service boundaries belong, what events should carry, and when a simple transaction script is better than a rich domain model.

## Service Boundaries and Splitting Entities

**Source:** [Defining Service Boundaries by Splitting Entities](https://www.youtube.com/watch?v=lGvYHmvXiyk) — CodeOpinion.

A useful way to find boundaries is to start with entities and inspect their properties. If an entity has many properties that are used by different parts of the business, it probably should not live in one service as a single shared object.

The anti-pattern is **"Entity as a Service"**: assuming an entity must live entirely in one context and that every other context must call that service to get it.

Instead, the same conceptual entity can appear in multiple bounded contexts, sharing an identifier but owning different data:

- **Catalog:** product identity, name, and description.
- **Sales:** sale price and available-to-promise (ATP).
- **Purchasing:** vendor cost and vendor or manufacturer details.
- **Warehouse:** quantity on hand.

Each context owns the data it needs and uses messages or events to keep its view current. For example, purchasing can publish an event when an order is placed, invoicing can publish an event when a customer order is invoiced, and the warehouse can publish inventory-adjusted events. Sales uses those events to maintain its ATP number and enforce ordering rules.

Heuristics:

- Look at the entity's properties and ask which context actually owns each one.
- Do not require an entity to live in only one place.
- Share the identifier, not all the data.
- If an entity has many unrelated properties used by different contexts, split it.
- Use events to maintain context-specific projections instead of synchronous calls to the producer.

## Thin vs. Fat Events

**Source:** [Thin or Fat Events? Are your boundaries right?](https://www.youtube.com/watch?v=vDtK-ccQWkw) — CodeOpinion.

- **Fat events** carry full state. They often start thin and grow as more consumers are added.
- **Thin events** carry identifiers only. Consumers fetch the data they need from their own context rather than calling the producer synchronously.
- **Delta events** carry partial changes and tend to couple consumers to the producer's internal model.

Thin events are usually the safer default because they keep the producer from becoming a shared data source. The consumer should resolve the data it needs from its own context, not from the producer's database or a synchronous query back to the producer.

## Transaction Script vs. DDD

**Source:** [From Transaction Scripts to Domain Models: A Refactoring Journey](https://milanjovanovic.tech/blog/from-transaction-scripts-to-domain-models-a-refactoring-journey) — Milan Jovanović.

Do not force Domain-Driven Design into every feature. For straightforward workflows, a simple **Transaction Script** can be the right starting point.

A transaction script handles a single request in a direct, readable way:

1. Validate the input data.
2. Calculate the result and apply the business logic.
3. Persist the changes.
4. Return the response.

This can be easy to read and test while the workflow remains simple. Avoid treating a fixed percentage of CRUD scenarios as a universal rule; choose based on the complexity and change patterns of the business rules.

Switch to a richer domain model when the business logic becomes "chatty": too many `if`/`else` branches, complicated state transitions, or rules that are hard to track in a single method.
