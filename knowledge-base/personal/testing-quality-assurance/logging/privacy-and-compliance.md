# Privacy, PII & Compliance

**Summary:** Do not log secrets, credentials, or personally identifiable information (PII). Know compliance constraints (PCI, GDPR) and implement redaction/sampling when needed.

- Never log passwords, security keys, auth tokens, or full credit card details.
- Treat PII carefully: minimize storage, mask or redact sensitive fields and expire logs according to policy.
- For regulated data (PCI/PII), prefer audit trails with restricted access and encryption at rest.
- Implement access controls and retention policies for logs containing sensitive metadata.

**Related:** [Formatting & Structured Logging](formatting-and-structure.md)

