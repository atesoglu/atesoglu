# Testing Tools & Approaches

**Summary:** A decision guide for contract testing, chaos engineering, test doubles, and supporting tools.

## Approaches

- **Contract testing**: Define and verify service contracts to prevent integration regressions. See [Microservices and End-to-End Testing](microservices-end-to-end-testing.md).
- **Chaos engineering**: Introduce controlled failures to validate resilience.
- **Mocking and fakes**: Choose between isolation and realistic behavior. See [Mocking vs Fakes](mocking-vs-fakes.md).

## Tool Selection

Choose tools based on the behavior being tested, feedback speed, production similarity, and maintenance cost. Tool names are implementation choices, not the testing strategy itself.

## Guidance

Use the minimum isolation needed to keep tests fast while preserving confidence in real integrations. Prefer focused, maintained tools over a long catalog of alternatives.

