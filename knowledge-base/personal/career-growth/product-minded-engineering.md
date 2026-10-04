# Product-Minded Engineering

**Summary:** Shifting the focus from "writing code" to "delivering value" using metrics and business alignment.

---

## 1. What is a Product-Minded Engineer?
A product-minded engineer (PME) understands the "why" behind every feature. They don't just wait for Jira tickets; they seek to understand user pain points and how their technical decisions impact business outcomes.

---

## 2. The DORA Metrics
The industry standard for measuring engineering performance and throughput. Focus on these to drive value:

| Metric | Description | Goal |
| :--- | :--- | :--- |
| **Deployment Frequency** | How often you ship code to production. | Daily / Multiple times a day. |
| **Lead Time for Changes** | Time from code commit to production. | Hours, not weeks. |
| **Change Failure Rate** | % of deployments requiring remediation. | < 15% |
| **Time to Restore (MTTR)** | How quickly you recover from failure. | < 1 hour. |

---

## 3. Key Mindset Shifts

### From Feature to Outcome
- **Feature**: "Build a PDF export button."
- **Outcome**: "Reduce the time support staff spends manually generating reports by 20%."

### Understanding Trade-offs
A PME knows when to build a "Perfect" solution vs. a "Good Enough" one based on product stage and validated learning.

---

## 4. Professional Micro-Rituals
- **Telemetry First**: Before shipping a feature, ask: "How will we know this worked as expected?" (OpenTelemetry, Custom Events).
- **Post-Mortem Culture**: Treat failures as learning opportunities for the entire team, focusing on process improvement over finger-pointing.
- **Manage Up**: Proactively communicate technical debt and its impact on product velocity to stakeholders.

---

## 5. Further Reading
- *Accelerate: The Science of Lean Software and DevOps* by Nicole Forsgren.
- *The Pragmatic Programmer* by Andrew Hunt.
