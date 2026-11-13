# Logging and Diagnostics

A practical policy for choosing what to log, how to structure it, and how to keep sensitive data out of logs.

## 1. Diagnostic vs Audit Logging

### Diagnostic Logging

- **Purpose:** Aid failure investigations and debugging.
- **Content:** Who, what, when, where, and why of failures; contextual IDs, error details, and stack traces when necessary.
- **Best practices:** Avoid printing entire objects. Prefer contextual fields such as IDs and a small set of attributes, and emit rich structured data.

### Audit Logging

- **Purpose:** Track business transactions and actions for legal, auditing, or reconciliation needs.
- **Content:** Business events, transaction records, and relevant metadata for audit trails.
- **Best practices:** Ensure immutability and tamper-evidence where required, and separate audit logs from diagnostic logs.

## 2. Structured Logging

Prefer structured logs over free-form text so entries can be parsed, searched, and processed downstream.

- Emit each entry with a timestamp, level, component, message, and contextual fields.
- Use consistent field names such as `request_id`, `user_id`, `org_id`, and `correlation_id`.
- Avoid printing large objects; log IDs or a small set of useful attributes.
- Keep log emission to stdout/stderr and let the platform handle collection and routing.

**Examples**

- Bad: `logger.info(user)` — prints the entire object.
- Good: `logger.info("user updated", { user_id: user.id, op: "update" })`

## 3. Privacy, PII, and Compliance

- Never log passwords, security keys, auth tokens, or full credit card details.
- Treat personally identifiable information (PII) carefully: minimize storage, mask or redact sensitive fields, and expire logs according to policy.
- For regulated data such as PCI or PII, prefer audit trails with restricted access and encryption at rest.
- Implement access controls and retention policies for logs containing sensitive metadata.

## 4. Use Cases and Practices

### Stakeholders

Developers, operations, QA, support and customer success, and occasionally end users. Tailor log messages to the expected reader: more technical for developers, higher level for support.

### Verbosity and Channels

- Use log levels such as debug, info, warn, and error consistently. Avoid using debug as a permanent "trash bin."
- Use emission categories such as KPI logs, per-flow logs, and a separate audit channel to separate concerns and control retention.

### Testing and Assertions

Consider asserting that important errors or warnings are emitted in tests, and that they are emitted only once where applicable.

### Sampling and Performance

Use sampling for very high-volume events such as telemetry, and keep structured summaries for analytics.

## 5. Core Reminders

- Provide context and log IDs rather than whole objects.
- Emit structured logs with a timestamp, level, component, message, and fields.
- Never log secrets or full PII. Use retention and access controls for sensitive logs.
