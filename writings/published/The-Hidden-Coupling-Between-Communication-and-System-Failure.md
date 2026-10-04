# The Hidden Coupling Between Communication and System Failure

*What “Inform, Involve, Inspire” Looks Like Under Load*

## The Hidden Coupling Between Communication and System Failure

### What “Inform, Involve, Inspire” Looks Like Under Load

### 1. The Engineering Tension: When Clean Diagrams Meet Messy Reality

Back in the day, we had two legacy systems with overlapping domains and expensive, duplicated infrastructure. The migration plan was surgically clean: merge the data, decommission the old nodes, and standardize the API contracts. The architecture diagrams were convincing, leadership was aligned, and the timelines were aggressive but — we thought — defensible.

What failed wasn’t the technical design. It was the system’s “connective tissue.”

Teams continued to build features on deprecated branches. Critical dependencies surfaced only after the first service went dark. Observability broke in subtle ways because different squads held different “hidden” assumptions about what a successful deployment actually meant. Communication, meanwhile, devolved into a series of status broadcasts that were high in volume but low in signal.

At some point, it became clear we weren’t executing a migration; we were running multiple, conflicting versions of reality in parallel.

This is the central tension Rachel Miller surfaces in *Successful Change Communication*. While the book is written for communicators, its core premise is a fundamental engineering truth: change doesn’t fail at the point of execution. It fails much earlier, when **alignment is assumed rather than constructed**. In the world of high-scale systems, we call this a coordination failure.

### 2. The Coordination Model: Inform, Involve, Inspire

Miller’s “Triple-I” framework — Inform, Involve, Inspire — is often read as a soft-skill guide for HR. However, when viewed through the lens of distributed systems, it reveals itself as a robust model for organizational consensus.

**Inform is Broadcast (Eventual Consistency)** In Miller’s framework, “Informing” is the baseline. It is the act of pushing state to the nodes. In engineering terms, this is a broadcast with no ACK (acknowledgement). You’ve updated the documentation, sent the email, and posted the Slack update. But as any SRE knows, sending a message is not the same as the system processing it. Nodes receive the state, but there is no guarantee they interpret or act on it correctly. Relying solely on “Informing” creates an organization that is “eventually consistent” at best — and often, the latency is so high that the system drifts into a failure state before consistency is ever reached.

**Involve is a Feedback Loop (Consensus Systems)** “Involvement” is where we move from message-passing to negotiation. Miller argues that people don’t resist change; they resist being excluded from it. In a technical system, this is the handshake. It introduces feedback loops where state isn’t just propagated — it’s reconciled. While “involvement” increases latency (it takes longer to get everyone in a room or a pull request), it drastically increases **correctness**. You are no longer just pushing a config change; you are validating that the downstream consumers can actually handle the new parameters.

**Inspire is Shared Intent (System Coherence)** “Inspire” is the most abstract layer, but it maps to the concept of **shared intent**. In a well-designed system, components don’t just follow hardcoded instructions; they behave predictably because they are governed by a shared logic or “purpose”. When employees are inspired — when they understand the “why” behind a change — they can make local decisions that align with the global objective without needing a constant stream of new instructions. This is the ultimate “low-latency” coordination.

### 3. The Dependency Explosion: Managing “Change Clusters”

One of the book’s most useful insights is that change is rarely a singular event. Miller frames this as **“Change Clusters”** — the idea that a single shift often triggers cultural, technological, and structural ripples.

In engineering, we call this dependency explosion. A “simple” database migration is never just a database migration. It is:

1. **A Contract Change:** Every service talking to that DB must update its schema.
2. **A Shift in Failure Modes:** The new DB might have different latency tails or locking behaviors.
3. **An Operational Burden:** The SRE team now has to learn a new set of metrics and alerts.
4. **A Developer Workflow Change:** The CI/CD pipeline needs new integration tests.

Treating this as a single-threaded “update” is how systems drift into inconsistency. Miller’s work suggests that we must map these clusters early. I’ve seen this play out in two directions:

- **The Convergent Path:** During a large-scale API redesign, we catalogued every service and consumer, pulling every owner into the “Involvement” phase early. It felt painfully slow upfront, but we avoided the typical cascade of runtime failures because the communication model matched the system topology.
- **The Divergent Path:** We once pushed a “minor” authentication change. We “Informed” everyone via a global email. Some teams missed it. Others cached tokens incorrectly. Others introduced retries that unintentionally DDoS’d the auth service. We had informed the nodes, but we hadn’t involved the owners. The result was a system-wide outage.

### 4. The Tension of Compliance and Control

While Miller leans toward inclusion as a default good, high-stakes engineering environments introduce a critical constraint: **Regulatory Pressure**.

In high-compliance sectors, the “Involve” phase is often limited. You cannot “negotiate” a security patch or a legal mandate required for an audit. In these cases, the “Spectra of Participation” (a concept Miller references) narrows. The trade-off shifts from alignment to **velocity and safety**.

The book acknowledges that if there is no room for participation, you must not pretend there is. In systems terms, if a change is a “hard-coded requirement,” don’t present it as a “configurable parameter.” Mismanaging this expectation creates an “integrity gap” that breaks the most important protocol in any organization: **Trust**.

### 5. Trust as a Latency Reducer

Miller views trust as the foundation of successful change. In engineering terms, **trust is what allows a system to operate without constant verification.** When trust is high, you don’t need “defensive coding” in your organizational processes. You don’t need three layers of approval for a minor change because you trust the local node (the team) to act in alignment with the shared intent.

When trust breaks, the system compensates with overhead. You see it in code through excessive retries and redundant checks. You see it in organizations through “shadow processes,” where teams stop using the official channels and start building their own duplicated workarounds just to keep moving. Both are symptoms of a lack of reliable coordination.

### 6. The “State” of History

Finally, Miller highlights that **past experiences shape current reactions**. In systems, this is simply “State.” You cannot deploy a new service and ignore the existing state of the database.

If an organization has a history of “poorly-managed change” (or what some call “change fatigue”), that is a stored variable you must account for. Ignoring the “technical debt” of past failed communications is a recipe for high resistance in the next deployment.

### 7. Practical Signals for System Health

Before approving a design or a rollout plan, I now look for the following “health checks” inspired by Miller’s framework:

- **The “Simple” Flag:** If a change is described as “simple,” assume there are hidden dependencies in a “Change Cluster”.
- **The Directional Check:** If communication is one-directional (Inform-only), expect divergence in the implementation.
- **The Edge Presence:** Are line managers (the “edge controllers”) empowered to act as change champions?.
- **The “Why” Validation:** Can the teams at the end of the chain articulate the “So What?” of the change?.

## Change as Convergence

What we take from Rachel Miller isn’t just a communication framework — it’s a design constraint. We must stop treating communication as an “overlay” on top of the work. It **is** the work.

Change is not a single moment in time. It is a transitional period where multiple versions of the system coexist. The only question that matters is whether those versions can converge into a new, stable state without breaking the organization in the process. By informing accurately, involving deeply, and inspiring clearly, we move from a system of “eventual consistency” to one of **intentional coherence**.