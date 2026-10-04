# Diagnostic vs Audit Logging

**Summary:** Diagnostic logging supports troubleshooting and root-cause investigations; audit logging captures business-critical actions for compliance and analysis.

## Diagnostic Logging
- Purpose: aid failure investigations and debugging.
- Content: who/what/when/where/why of failures; contextual IDs, error details, stack traces when necessary.
- Best practices: avoid printing entire objects, prefer contextual fields (IDs, small attribute sets) and emit rich structured data.

## Audit Logging
- Purpose: track business transactions and actions for legal, auditing, or reconciliation needs.
- Content: business events, transaction records, relevant metadata for audit trails.
- Best practices: ensure immutability, tamper-evidence where required and separation from diagnostic logs.

**Related:** [Formatting & Structured Logging](formatting-and-structure.md) — structured data and field naming conventions.

