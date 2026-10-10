# Staff Observability Interview Cheat Sheet

This version is tailored to your context: observability, SLOs, reliability, telemetry design, and the kind of Senior/Staff-level reasoning that is relevant for an Adyen-style discussion.

---

## 1. Your core answer model

If they ask broadly:

> “Tell me how you approached observability for the CDR pipeline.”

Use this structure:

Business outcome → critical path → SLIs → SLOs → error budget → alerting → diagnosis → scale/governance

A strong opening answer:

> “I didn't start with dashboards or infrastructure metrics. I started with the business-critical CDR flow and asked: what does healthy processing actually mean?
>
> From there I defined SLIs around acceptance, successful calculation, latency, freshness and pricing. I separated technical failures from expected business outcomes so the reliability signal reflected actual platform health rather than normal domain behavior.
>
> Then I turned those into SLOs and error budgets, and used multi-window burn-rate alerts so we could respond to both severe and sustained degradation. Finally, I made the definitions version-controlled so observability became part of the engineering lifecycle instead of a manually maintained dashboard.”

This is your backbone.

---

## 2. The CDR flow to anchor your answer

Use the actual flow if relevant:

OcpiCpoService → CdrService → BillingServiceV2

This shows you are not discussing observability abstractly; you are grounding it in the critical path.

If needed, say:

> “I first mapped the business-critical path to identify where a failure would materially affect the customer or downstream financial outcome.”

That is a Staff-level way to start.

---

## 3. SLO design: what to say

### Good framing

> “I wanted each SLO to represent a meaningful user or business-facing failure mode, not just a service being up.”

### Example SLOs

| SLO | Target | What it answers |
|---|---:|---|
| CDR ingest acceptance | 99.5% | Are valid CDRs entering the system successfully? |
| CDR calculation success | 99.9% | Can we calculate CDRs successfully? |
| Calculation latency | 99% within 0–30s | Are calculations completing fast enough? |
| Pipeline freshness | 99% within 300,000 ms | Is processing keeping up with incoming data? |
| Pricing success | 99.9% | Can we successfully price eligible CDRs? |

### Important nuance

> “The percentage is not a universal truth; it is a reliability contract based on business criticality and what is operationally achievable. The important part is that the target is explicit, measured, and revisited with evidence.”

### If they ask why these values

Don't sound like you believe 99.9% is automatically correct.

Say:

> “The exact threshold depends on criticality and past performance. The point is to define a measurable reliability contract and use error-budget burn to tell us whether those assumptions still hold.”

---

## 4. Why business failures should be excluded from technical reliability SLOs

This is one of the strongest questions for you.

### Core answer

> “Because an SLO should measure the reliability of the system, not punish the system for doing the correct business thing.”

### Example

If a CDR is rejected because of a valid business rule or expected domain condition, that is not necessarily a technical outage.

A good answer:

> “I did not want the technical reliability signal to be polluted by expected business outcomes. At the same time, I did not ignore those cases; I classified them separately so that we still had visibility into business behavior without letting them consume the technical error budget.”

### The Staff-level nuance

> “If the business outcome itself is the service promise, then it belongs in the SLO. If it's an expected domain result, it should be classified separately instead of counting as system failure.”

This shows mature SLO thinking.

---

## 5. First-attempt failures vs retries

This is probably your strongest observability story.

### The problem

If you only track “eventually succeeded,” you can hide the health of the primary path.

### Strong answer

> “I separated first-attempt health from retry recovery because retries can mask degradation in the original processing path. An eventual success metric can look healthy while the primary system is failing badly and relying on recovery mechanisms to compensate.”

### Your model

Track:
- initial attempt success/failure
- retry success/failure
- retry backlog
- end-to-end recovery latency

### Important phrase

> “Retries are a resilience mechanism, not evidence that the original attempt was healthy.”

This is very strong.

---

## 6. Error budgets and burn-rate alerts

### Core concept

> “An error budget tells me how much unreliability we're allowed. Burn rate tells me how quickly we're consuming it.”

### Useful burn-rate windows

- 1h + 5m → 14.4x → severe / fast burn
- 6h + 30m → 6x → serious sustained degradation
- 24h + 2h → 3x
- 72h + 6h → 1x

### Why both windows matter

> “The short window gives sensitivity, while the long window prevents a brief blip from causing noise. Requiring both to breach gives us a signal that is fast and sustained, rather than just noisy or delayed.”

### If asked why not alert on raw error rate

> “Because absolute error rate alone does not tell me whether the failure is meaningful relative to the service's reliability objective. Burn rate links the observed failure rate directly to the remaining error budget.”

---

## 7. Telemetry cardinality: what to say

### Principle

> “Bounded dimensions belong in metrics; high-cardinality identifiers belong in traces and logs.”

### Good metric dimensions
- service
- environment
- region
- operation
- event_type
- outcome
- dependency

### Dangerous dimensions
- customer_id
- transaction_id
- cdr_id
- request_id
- raw error message
- stack traces
- URL query strings

### Strong answer

> “Cardinality is a resource constraint, not just a schema decision. Before adding a dimension, I ask whether it's bounded, whether the team actually needs to aggregate on it, and whether that detail belongs in metrics at all.”

Then add:

> “High-cardinality identifiers are more appropriate in traces or structured logs, where we can preserve diagnostic detail without exploding the number of metric time series.”

This is very relevant for large-scale observability and Adyen-like systems.

---

## 8. Telemetry schema and governance

### Good framing

> “At three services, inconsistent naming is annoying. At thirty services, it becomes a platform problem.”

### What the schema should include
- service
- operation
- event_type
- outcome
- error_type
- region
- environment
- dependency
- retry_attempt
- timestamp
- trace_id

### Strong answer

> “I would establish a canonical telemetry contract so teams do not invent different meanings for the same concepts. That includes semantic consistency, outcome classification, alert taxonomy, and validation in CI so incompatible fields do not silently appear.”

This connects well with observability-as-code and standardization.

---

## 9. How to scale from a few services to many

### Step 1: standardize
- common OpenTelemetry setup
- common resource attributes
- common metric naming
- common outcome taxonomy
- trace/log correlation
- standard SLO patterns

### Step 2: make onboarding cheap
- shared templates
- dashboards and alerts as code
- standard instrumentation libraries
- CI validation
- clear onboarding checklist

### Step 3: platform governance
- cardinality controls
- retention policy
- schema ownership
- sampling policy
- quotas
- alert ownership

### Great line

> “The paved road should be easier than inventing observability from scratch.”

This sounds like a platform-minded Staff Engineer.

---

## 10. What “multi-petabyte scale” means

You do not need to pretend you have operated that scale.

### Understand the concept

A petabyte is roughly 1 million GB. Multi-petabyte means several PB of telemetry data retained across storage tiers and systems.

### The important idea

> “Multi-petabyte observability is not just one giant database. It is usually a distributed platform with hot, warm, and cold storage, buffering, indexing, query routing, retention policies, and strict governance around cost and cardinality.”

### Example architecture

- ingestion → collectors / gateways
- buffer / brokers
- processing layer
- hot storage for recent data
- warm storage for mid-term retention
- cold or archive storage for long retention
- query layer for dashboards, diagnostics, and investigation

### Good answer if asked about scale

> “I have not operated a multi-petabyte telemetry platform at Adyen's scale, and I would not claim that. But the principles are familiar: design for throughput, retention, query cost, and controlled cardinality. At larger scale, the architecture becomes much more about storage tiers, search/index strategy, ingestion governance, and platform design rather than simply collecting more logs.”

That is honest and credible.

---

## 11. Interview-ready phrases to memorize

Use these directly:

- “I started from the business-critical flow, not from dashboards.”
- “An SLO should reflect meaningful failure modes, not just whether a service responds.”
- “Expected business outcomes should not consume the technical reliability error budget.”
- “Retries are a resilience mechanism, not proof that the original path was healthy.”
- “Burn rate connects technical degradation to the reliability objective.”
- “At scale, cardinality is a platform design problem, not just a metric-labeling problem.”
- “The paved road should be easier than inventing observability from scratch.”
- “Observability is not about collecting more telemetry; it is about defining what healthy means and making that actionable.”

---

## 12. The strongest final answer you can give

If they ask a broad “what did you learn?” question, use this:

> “The biggest lesson was that observability is not about collecting more telemetry. It is about defining what healthy means and making that definition actionable.
>
> For the CDR pipeline, I started from the business-critical path, defined SLIs around acceptance, successful processing, latency, freshness and pricing, and deliberately separated expected domain outcomes from technical failures.
>
> I also separated first-attempt failures from retries because recovery should not hide degradation in the primary path. Then I used a 30-day error budget and multi-window burn-rate alerts so we could respond to both severe and sustained problems.
>
> As the system scales from a few services to dozens, the challenge shifts from individual instrumentation to platform governance: common telemetry contracts, bounded cardinality, version-controlled SLOs, reusable dashboards and alerts, retention policies, and self-service onboarding.
>
> That is the part I think matters most: making good observability the default rather than depending on every team to become a telemetry expert.”

This is a strong Staff-level response.

---

## 13. Quick answer checklist before the interview

Before you answer any observability question, check:

- Did I start from business outcome and critical path?
- Did I define a clear SLI/SLO model?
- Did I separate domain behavior from technical failure?
- Did I account for retries vs first attempts?
- Did I explain alerting in terms of burn rate and error budget?
- Did I mention cardinality and telemetry governance?
- Did I talk about platform-level scaling, not only service-level metrics?
- Did I stay honest about scale and expertise?

If all of that is true, you are speaking like a strong Staff candidate.

---

## 14. What not to say

Avoid:

- “We just added OpenTelemetry and everything was fine.”
- “We created some dashboards and alerts.”
- “We used 99.9% because that's standard.”
- “Any error is a problem.”
- “Retries mean the system is healthy.”
- “If we just collect more logs, we will find the issue.”
- “At our scale this was easy.”

These phrases sound tactical or shallow.

---

## 15. What you should emphasize

The strongest themes for your profile:

- system-critical thinking
- business-aware reliability design
- clear separation of signal vs noise
- strong SLO and error-budget reasoning
- recovery metrics and retry health
- platform-minded observability thinking
- scale-aware telemetry architecture
- honest and mature understanding of limits

That combination is very compelling for a Staff/leadership observability conversation.
