# Testing Strategy

A practical guide to choosing what to test, how much isolation to use, where to run the tests, and how to keep feedback fast.

## 1. Why Testing Matters

1. **Find defects earlier:** Tests can reveal incorrect behavior before it reaches users, reducing the cost and impact of many defects.
2. **Facilitate changes:** A relevant test suite provides regression feedback and can make updates or refactoring less risky, but it cannot guarantee that changes are defect-free.
3. **Support design feedback:** Testing can encourage modularity and expose awkward boundaries, but it does not guarantee a good design.
4. **Document behavior by example:** Tests can show expected behavior and help team members understand important cases.
5. **Support onboarding:** Tests offer executable examples of system behavior and use cases.
6. **Increase confidence in change:** Useful tests provide evidence about behavior while monitoring and other quality practices remain necessary.
7. **Encourage deliberate work:** Writing tests can prompt smaller steps and earlier consideration of edge cases.

### TDD and Coverage

Test-driven development (TDD) is a development cycle: write a failing test, write enough code to make it pass, then refactor while keeping the tests green. It is not a strategy for maximizing code coverage.

Coverage measures which code was exercised, not whether assertions meaningfully verify behavior. A suite can reach 100% coverage with weak or no assertions, so interpret coverage alongside test quality and risk.

TDD can help clarify expected behavior and support design feedback, but it does not guarantee a good design or a complete specification. Coverage may increase as tests are added, but it is neither a guaranteed byproduct nor the goal of TDD.

## 2. Test Types

- **Unit tests:** Check small units of behavior in isolation.
- **Integration tests:** Verify interactions with real infrastructure or collaborating components.
- **Contract tests:** Check that service interfaces remain compatible, for example with Pact.
- **End-to-end (E2E) tests:** Verify selected user or business workflows across system boundaries.
- **Load and performance tests:** Measure latency, throughput, and resource use under defined workloads.
- **Stress and resilience tests:** Explore behavior beyond expected capacity or during dependency failures.
- **Security tests:** Identify vulnerabilities and verify security requirements; these are distinct from load or stress tests.

Use the smallest test that gives useful confidence. A healthy suite usually has many fast unit tests, a meaningful layer of integration and contract tests, and a small number of high-value E2E tests.

## 3. Test Doubles: Mocks vs Fakes

Mocks are simulated objects that replace real objects to control the behavior of external dependencies such as databases and APIs. Fake objects are lightweight implementations of real dependencies, such as an in-memory database, that work similarly to the real thing.

### Mocks

**Advantages:** Isolation from external failures, speed, and flexibility for programming scenarios and edge cases.

**Disadvantages:** They may not reflect real behavioral nuances, can make tests harder to maintain and debug, and can be programmed incorrectly.

### Fakes

**Advantages:** Closer behavior to the real dependency and often simpler setup than complex mock configurations.

**Disadvantages:** They can be slower than mocks and less configurable for specific edge cases.

**Guidance:** Choose based on the goal. Use mocks for hard-to-reproduce edges; use fakes for stateful logic verification. Use the minimum isolation needed to keep tests fast while preserving confidence in real integrations.

## 4. Testing Microservices and E2E Workflows

In a complex system with multiple services and integrations, combine unit, integration, contract, E2E, performance, stress, and security tests rather than relying on one layer.

### E2E Best Practices

1. **Test workflows:** Focus on user journeys, not just services.
2. **Use realistic data:** Mirror production usage where it matters.
3. **Isolate tests:** Ensure tests do not depend on each other.
4. **Avoid hard dependencies:** Use mocks or stubs where appropriate for stability.
5. **Run in parallel:** Execute tests concurrently to save time.
6. **Monitor performance:** Track response times during tests.
7. **Test across environments:** Cover dev, staging, and production-like environments.

### Tooling by Role

- **Playwright:** A strong default for browser-based E2E testing, with multi-browser support, parallel execution, tracing, and .NET/Java/Node.js/Python clients.
- **Cypress:** Browser-focused E2E and component testing with an interactive developer experience.
- **Selenium:** Mature WebDriver ecosystem and broad language and browser support, useful where an existing Selenium investment or specialized browser integration matters.
- **Testcontainers:** Reproducible disposable databases and services for integration tests; it is test-environment tooling rather than an E2E browser framework.

Choose a maintained tool that fits the application boundary, browser coverage, debugging needs, and existing team expertise. Protractor is retired, and Jest is a JavaScript test runner rather than a general-purpose browser E2E framework.

## 5. CI/CD and Feedback Loops

- Run fast, relevant checks for each change. Run broader integration, E2E, performance, and security suites at a cadence appropriate to their cost and feedback value.
- Automate builds and test execution; deploy to staging after the required quality gates pass.
- Parallelize suites where it shortens feedback time without making resource contention or test flakiness worse.
- Use **contract testing** to define and verify service contracts and prevent integration regressions.
- Use **chaos engineering** to introduce controlled failures and validate resilience.

## 6. Cloud and Scaling

Cloud testing can provide scalability, flexibility, cost savings, and accessibility: run many tests in parallel, switch environments on demand, pay for what you use, and access results from anywhere.

Cloud providers offer hosted runners and storage for test artifacts. Managed or cloud runners can simplify scaling, but cost depends on concurrency, run duration, and the required test infrastructure.

### Google Cloud Platform Services

- **Compute Engine:** VMs for custom test runners.
- **Kubernetes Engine (GKE):** Scalable containerized testing.
- **Cloud Build:** Managed CI/CD platform.
- **Cloud Operations (formerly Stackdriver):** Monitoring and logging for test runs.
- **Cloud Storage:** Store test artifacts and results.

## 7. Tool Selection

Choose tools based on the behavior being tested, feedback speed, production similarity, and maintenance cost. Tool names are implementation choices, not the testing strategy itself.

Prefer focused, maintained tools over a long catalog of alternatives.

## Related

- [Staging Environment Management](staging-environment-management.md)
- [Testing Metrics and Reporting](testing-metrics-and-reporting.md)
- [QA and Software Architect Collaboration](qa-software-architect-collaboration.md)
- [.NET Runtime Metrics](dotnet-runtime-metrics.md)
