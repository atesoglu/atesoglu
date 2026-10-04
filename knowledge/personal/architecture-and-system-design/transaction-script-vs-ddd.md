# Transaction Script vs DDD

**Summary:** A pragmatic reminder to start with a simple Transaction Script for straightforward workflows and introduce a richer domain model when business rules and state transitions justify it.

**Source:** [From Transaction Scripts to Domain Models: A Refactoring Journey](https://milanjovanovic.tech/blog/from-transaction-scripts-to-domain-models-a-refactoring-journey) by Milan Jovanović.

Stop trying to force Domain-Driven Design into every feature.

For straightforward workflows, a simple Transaction Script can be the right starting point.

Transaction Script is a classic pattern described by Martin Fowler. Avoid treating any fixed percentage of CRUD scenarios as a universal rule; choose based on the complexity and change patterns of the business rules.

Instead of building complex aggregates and value objects, you just write a simple, procedural script that handles a single request:

1. 𝗩𝗮𝗹𝗶𝗱𝗮𝘁𝗲 the input data.
2. 𝗖𝗮𝗹𝗰𝘂𝗹𝗮𝘁𝗲 the result (business logic).
3. 𝗣𝗲𝗿𝘀𝗶𝘀𝘁 the changes to the database.
4. 𝗥𝗲𝘁𝘂𝗿𝗻 the response.

It can be direct, readable, and easy to test while the workflow remains simple.

The linked article provides a side-by-side example of a Transaction Script and a Rich Domain Model.

👉 When to switch: Start with a Transaction Script. Only refactor to a Domain Model when the business logic becomes "chatty", meaning you have too many if/else blocks or complicated state transitions that are hard to track in a single method.