# Use Cases & Best Practices

**Summary:** Practical guidance on stakeholders, verbosity levels, emission channels and sampling strategies to keep logs reliable and actionable.

## Stakeholders
- Developers, Ops, QA, Support/Customer Success and occasionally end-users.
- Tailor log messages to the expected reader (more technical for developers, higher level for support).

## Verbosity & Channels
- Use log levels (debug/info/warn/error) consistently and avoid debug as a permanent "trash bin".
- Emission categories (KPI, per-flow logs, audit channel) help separate concerns and control retention.

## Testing & Assertions
- Consider asserting that important errors or warnings are *emitted* in tests and only emitted once where applicable.

## Sampling & Performance
- Use sampling for very high-volume events (e.g., telemetry) and keep structured summaries for analytics.

**Related:** [Diagnostic vs Audit Logging](diagnostic-vs-audit.md) — when to use diagnostic vs. audit outputs.

