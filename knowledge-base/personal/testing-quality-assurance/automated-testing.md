# Automated Testing & CI/CD

**Summary:** Overview of automated testing types, CI/CD integration and running tests at scale (including cloud options).

## Types of Tests
- Unit tests: Check small units of behavior in isolation.
- Integration tests: Verify interactions with real infrastructure or collaborating components.
- Contract tests: Check that service interfaces remain compatible (for example, using Pact).
- End-to-end tests: Verify selected user or business workflows across system boundaries.
- Load and performance tests: Measure latency, throughput, and resource use under defined workloads.
- Stress and resilience tests: Explore behavior beyond expected capacity or during dependency failures.
- Security tests: Identify vulnerabilities and verify security requirements; these are distinct from load or stress tests.

## CI/CD Integration
- Run fast, relevant checks for each change. Run broader integration, end-to-end, performance, and security suites at a cadence appropriate to their cost and feedback value.
- Automate builds and test execution; deploy to staging after the required quality gates pass.
- Parallelize suites where it shortens feedback time without making resource contention or test flakiness worse.

## Cloud & Scaling Notes
- Cloud providers offer hosted runners and storage for test artifacts.
- Managed or cloud runners can simplify scaling, but cost depends on concurrency, run duration, and required test infrastructure.

