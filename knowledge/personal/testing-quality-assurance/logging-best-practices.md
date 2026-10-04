# Logging Best Practices

**Summary:** Core guidance; the full, detailed guidance is split into focused pages in `testing-quality-assurance/logging/`.

- [Diagnostic vs Audit Logging](logging/diagnostic-vs-audit.md)
- [Formatting & Structured Logging](logging/formatting-and-structure.md)
- [Privacy, PII & Compliance](logging/privacy-and-compliance.md)
- [Use Cases & Best Practices](logging/use-cases-and-practices.md)
- [Logging Index](logging/README.md)

**Quick tips:**
- Provide context and log IDs rather than whole objects.
- Emit structured logs (timestamp, level, component, message, fields).
- Never log secrets or full PII. Use retention and access controls for sensitive logs.

Use the [Logging Index](logging/README.md) to navigate the focused guidance and historical archive.

