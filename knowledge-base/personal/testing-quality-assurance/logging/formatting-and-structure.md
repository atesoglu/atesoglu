# Formatting & Structured Logging

**Summary:** Emit logs as structured data (e.g., JSON) with clear fields rather than free-form text to improve parsing, observability and downstream processing.

- Prefer structured logs: each entry should have timestamp, level, component, message and contextual fields.
- Use consistent field names (e.g., request_id, user_id, org_id, correlation_id).
- Avoid printing large objects; log IDs or a small set of useful attributes.
- Keep log emission to stdout/stderr and let the platform handle collection and routing.

**Examples**
- Bad: `logger.info(user)` — prints entire object
- Good: `logger.info("user updated", { user_id: user.id, op: "update" })`

**Related:** [Privacy, PII & Compliance](privacy-and-compliance.md)

