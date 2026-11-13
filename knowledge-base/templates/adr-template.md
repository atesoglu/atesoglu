# Decisions

Architecture Decision Records (ADRs), tradeoff analyses, and lessons learned from significant technical choices.

## Purpose

This folder captures **why** certain architectural or technical decisions were made, so future readers (including future me) understand the context, alternatives considered, and expected consequences.

## Format

Each decision should be a separate Markdown file named `YYYY-MM-DD-short-title.md` with this structure:

```markdown
# Title

**Date**: YYYY-MM-DD
**Status**: Proposed | Accepted | Superseded | Deprecated
**Context**: What situation led to this decision?
**Decision**: What was chosen?
**Alternatives**: What else was considered?
**Consequences**: What are the tradeoffs (positive and negative)?
**Links**: Related docs, issues, PRs
```

## Index

*(No decisions recorded yet. Add files as decisions are made.)*

---

## Guidance

- Write decisions **close to the time they're made**, not retroactively
- Include **enough context** that someone unfamiliar with the situation can understand
- Be honest about **uncertainties and risks**
- Link to related code, docs, or discussions
- If a decision is later changed, add a new ADR that **supersedes** the old one (don't delete)