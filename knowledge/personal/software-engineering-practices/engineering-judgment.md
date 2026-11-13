# Engineering Judgment

A compact set of principles for building software that serves people, survives operations, and stays maintainable.

## Engineering Principles

- Complexity becomes most expensive during operations and on-call work.
- Do not fall in love with your own code.
- Every design is a trade-off; there is no universal best solution.
- Every line of code is a maintenance liability.
- Record important designs and decisions.
- Avoid unnecessary dependencies.
- Coding standards prevent repeated arguments.
- Write meaningful commit descriptions.
- Use code review to spread context, not only to police quality.
- Prefer maintainability and simplicity.
- Ask for help when blocked.
- Fix root causes rather than symptoms.
- Software is never truly finished.
- Estimates are not promises.
- Ship early and iterate deliberately.

## People-First Engineering

- Software engineering is more about people than code.
- Code doesn't matter unless it serves the business.
- Know when to hack something together versus when to build a masterpiece.
- Simplifying complex things will take you places.
- Respect the sales, marketing, and legal teams.
- Simple beats clever in the long term.
- Your code won't love you back.

## Software Quality Perspectives

### Modern Perspectives

- **Agile:** Collaboration, flexibility, and short sprints.
- **DevOps:** Collaboration between development and operations, with automation.
- **Human-centered design:** User-centric and accessible software.
- **Microservices:** Decomposed, independently deployable services.
- **Security-focused:** Security integrated from the start.

### Challenges

- Ensuring maintainability while delivering features.
- Balancing speed with stability.
- Keeping up with technology changes.

### Best Practices for Quality

1. **Code review:** Catch bugs and share knowledge.
2. **Automated testing:** Unit, integration, and E2E.
3. **CI/CD:** Automate build, test, and deploy.
4. **Performance monitoring:** Identify bottlenecks in production.
5. **Design patterns:** Ensure maintainable architecture.
6. **Refactoring:** Regularly improve code structure.
7. **Continuous learning:** Learn from failures and successes.
8. **Prioritize security:** Test and review security continuously.

## Applying Abstractions

Abstraction is most effective when it meets a few key criteria:

- It reduces overall cognitive load rather than introducing additional intellectual burden.
- It is intuitive, making it easy to reason about and explain to fellow developers.
- It avoids leaking implementation details, so it does not introduce more overhead or complexity than the value it provides.
