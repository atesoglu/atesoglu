# Beyond Conciliation: When “Meeting in the Middle” Breaks Distributed Systems

*Why Some Of The Technical Conflicts Can’t Be Solved with More Data*

## Beyond Conciliation: When “Meeting in the Middle” Breaks Distributed Systems

### Why Some Of The Technical Conflicts Can’t Be Solved with More Data

In high-stakes engineering, we often treat persistent disagreement as a data problem. We assume that with enough benchmarks, whiteboards, or RFC revisions, the “correct” architectural path will eventually reveal itself through sheer logic.

But after twenty years of building distributed systems and leading migrations, I’ve realized that some of our most intense technical frictions aren’t actually about the technology. They are what philosophers call “deep disagreements”, clashes of foundational assumptions that no amount of data can resolve.

When we hit these walls, the role of a Tech Lead shifts from being a judge of evidence to being an investigator of mental models. This is a reflection on how the philosophy of disagreement changed how I view consensus, trade-offs, and the limits of the “right” reason in complex systems.

## 1. Opening: A Real Engineering Tension

A few years ago, I led a high-stakes migration for a core payments engine. We were moving from a monolithic, synchronous processing model to a globally distributed, event-driven architecture. The technical challenges; idempotency, clock skew, and eventual consistency, were well-understood, but the project nearly stalled because of a persistent friction between two senior leads. One argued for strict “at-most-once” delivery to prevent any chance of double-charging, while the other insisted on “at-least-once” with aggressive retry logic to ensure no payment was ever lost. Both were right within their own mental models of reliability, yet their disagreement felt fundamental, almost unresolvable.

It wasn’t until I sat down with *The Routledge Handbook of Philosophy of Disagreement* that I realized we weren’t just arguing about message brokers. We were trapped in what philosophers call a “deep disagreement”. In software engineering, we often treat disagreement as a lack of data; we assume that if we just run one more benchmark or write one more RFC, the “correct” path will emerge. But the philosophy suggests that some conflicts arise not from a lack of evidence, but from a clash of “hinge” commitments , the foundational assumptions that determine how we interpret evidence in the first place.

## 2. The Book’s Core Idea (Reframed)

One of the most striking mental models in the handbook is the tension between *Conciliationism* and *Steadfastness*. Conciliationists argue that when you encounter an “epistemic peer”, someone with the same data and intelligence who disagrees with you, you should move your position toward theirs. In a tech lead role, this is our default: we seek the middle ground, the compromise. However, the “Right Reasons” view suggests that if you have actually responded correctly to the evidence, you are rational to remain steadfast, even if a peer disagrees.

In a cloud-native environment, this philosophical tension has immediate architectural consequences. If two leads disagree on a consistency model for a distributed database, a conciliationist approach; trying to build a “hybrid” that satisfies both, often results in a system that is complex, brittle, and performs poorly under load. By trying to “meet in the middle,” you might create a system that lacks the clear failure modes of either original design. The handbook’s exploration of “higher-order evidence” reminds us that the mere fact of a peer’s disagreement is itself data. In my experience, when two senior engineers disagree, the signal isn’t that one is wrong; it’s that the system’s requirements are under-specified or that we are operating in a “permissive” environment where multiple rational designs are possible.

## 3. Deep Technical Examination

This leads to the concept of “faultless disagreement,” a notion often applied to matters of taste but highly relevant to meta-architectural debates. When we argue over whether a service should be written in Go or Rust, or whether to use K8s vs. Serverless, we are often in a realm where both parties are “faultless” because they are operating under different internal standards of assessment. One engineer prioritizes developer velocity; the other prioritizes memory safety and runtime predictability. The handbook notes that in such cases, neither party is making a cognitive error relative to their own standards. The failure, then, is not one of logic, but of organizational alignment. We haven’t agreed on what “good” looks like for this specific project.

We also see this play out in technical “insulation.” The handbook discusses “virtuous advocacy,” where a proponent of a view may continue to champion it even under conditions of disagreement. We see this in engineering teams where a proponent of a new technology might bracket known operational overhead to push for a migration they believe will be beneficial in the long run. While this can drive innovation, the handbook warns that such “belief-substitutes” — attitudes used to drive action without total belief — can be dangerous if the underlying evidence doesn’t actually support them.

## 4. Systems Thinking Layer

Elevating the argument, we must recognize that disagreement scales across an organization. When a company experiences “affective polarization,” disagreements over technical debt stop being about the code and start being about identity. The handbook discusses how outrageous claims can become “signals of membership”. I’ve seen this in “language wars,” where an engineer’s insistence on a specific tool is less about its technical merits and more about signaling their status as a “modern” or “principled” developer.

Ultimately, the goal isn’t to eliminate disagreement, but to manage its “epistemic significance”. We need to recognize when we are facing a “deep disagreement” that no amount of benchmarking will solve. In those moments, the senior engineer’s job isn’t to find the “right” answer through more data, but to surface the underlying “hinge” assumptions and force a decision based on the business’s actual risk appetite.

## 5. Practical Signals

Signals that a technical disagreement is structurally deep:

- **The “One More Benchmark” Trap**: When parties agree on the data but still interpret its meaning in opposite ways.
- **Hinge Friction**: When the argument eventually boils down to foundational “truths” (e.g., “Latency is the only thing that matters”).
- **Identity Signaling**: When the choice of technology becomes a proxy for an engineer’s professional identity.
- **Recursive Circularity**: When the evidence used to support a position is only valid if you already accept that position’s underlying logic.

## 6. Closing Reflection

Engineering leadership is often sold as a series of optimization problems. We are told that if we are smart enough and our telemetry is detailed enough, the path forward will be obvious. But the most significant systems I’ve built were born out of disagreements that couldn’t be solved with more data. They required a different kind of work: the work of acknowledging that two peers can look at the same system and see two different, equally valid realities. Accepting that “faultless disagreement” exists doesn’t make us less decisive; it makes us more honest about the trade-offs we are actually making.