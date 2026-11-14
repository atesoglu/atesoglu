# Architecture Decision Record Template

Use this template to capture **why** an architectural or technical decision was made, so future readers understand the context, alternatives, and expected consequences.

## When to Use an ADR

Write an ADR when a decision:

- Changes system structure, boundaries, or dependencies.
- Introduces a significant technology or platform choice.
- Accepts a meaningful trade-off that future maintainers should know about.
- Is likely to be revisited or superseded.

## Template

Copy the block below into a new file named `YYYY-MM-DD-short-title.md`.

```markdown
# [Short, specific decision title]

- **Date:** YYYY-MM-DD
- **Status:** Proposed | Accepted | Superseded | Deprecated
- **Owner:** [Name or role]
- **Context:** What situation led to this decision?
- **Decision:** What was chosen?
- **Alternatives considered:** What else was evaluated, and why was it rejected?
- **Consequences:** What are the positive and negative outcomes?
- **Follow-up actions:** What must happen next, if anything?
- **Links:** Related documents, issues, pull requests, or discussions.
```

## Writing Guidance

- Store each ADR as a separate file in the project's decision-record folder.
- Write decisions **close to the time they are made**, not retrospectively.
- Include enough context that someone unfamiliar with the situation can understand it.
- Be honest about uncertainties, risks, and negative consequences.
- Link to related code, documents, issues, or discussions.
- If a decision changes later, add a new ADR that **supersedes** the old one instead of deleting history.
