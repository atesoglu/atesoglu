# The Best of All Possible Codebases

*What Leibniz’s Moral Philosophy Reveals About System Design, Technical Debt and Engineering Failure*

## The Best of All Possible Codebases

### What Leibniz’s Moral Philosophy Reveals About System Design, Technical Debt and Engineering Failure

In [**Leibniz’s Moral Universe**, T. Allan Hillman](https://www.amazon.nl/-/en/Leibnizs-Moral-Universe-Metaphysics-Ethics/dp/3032110726) reconstructs a powerful idea: for Leibniz, metaphysics and ethics are continuous. Structure determines value. Reality is moral because it is ordered.

This isn’t abstract theology, it’s distributed systems theory in disguise.

If you replace:

* “**God**” with “**system architect**”* “**possible worlds**” with “**design alternatives**”* “**perfections**” with “**system invariants**”* “**virtue**” with “**engineering discipline**”

You get a surprisingly precise model of modern software architecture. Let’s go technical.

## 1. “The Best of All Possible Worlds” = Optimization Under Constraints

Leibniz argues that from infinitely many possible worlds, one is selected because it maximizes overall coherence, order and value under constraints. That is exactly what happens in real system design.

When you choose:

* Strong consistency vs. eventual consistency* Synchronous vs. asynchronous messaging* Vertical vs. horizontal scaling* Polyglot persistence vs. unified schema* Monolith vs. microservices

You are not searching for perfection. You are optimizing across a multidimensional constraint surface.

### Case Study: Netflix — Embracing Eventual Consistency

Netflix [intentionally embraced](https://netflixtechblog.com/netflixs-distributed-counter-abstraction-8d0c45eb66b2):

* Microservices* Event-driven communication* Eventual consistency* Chaos engineering

**Why?**

Because global scale (200M+ users) made strong consistency prohibitively expensive and latency-sensitive.

They chose:

* System resilience over transactional purity* Observability over centralized control* Autonomous services over monolithic coordination

This is Leibnizian optimization: maximize systemic harmony given global constraints. Not perfect. Optimal under pressure.

## 2. Perfection = Realizing Invariants

In Hillman’s reconstruction, “perfection” means:

> A thing fully realizing what it is supposed to be.

In engineering terms:

* A service satisfies its invariants.* A database guarantees its constraints.* A distributed protocol preserves safety and liveness.* An API contract is stable and versioned correctly.

Perfection = invariant preservation.

When invariants collapse, moral disorder appears. In distributed systems, that disorder is usually called:

* Data corruption* Race conditions* Inconsistent state* Cascading failure

### Case Study: Knight Capital (2012)

Knight Capital [deployed new trading software without removing old, deprecated flag logic](https://www.henricodolfing.ch/case-study-4-the-440-million-software-error-at-knight-capital/).

Result:

* A dormant feature was reactivated.* The system violated its own state assumptions.* $440 million lost in 45 minutes.* Company effectively collapsed.

This was not a moral failure in the ethical sense. It was a failure of invariant discipline.

Leibniz would say:

> The system ceased to realize what it was supposed to be.

Structural incoherence → catastrophic consequences.

## 3. Monads = Autonomous Services With Internal Determinism

Leibniz describes reality as composed of “monads”:

* Self-contained* No direct interference* Internally driven* Globally coordinated through harmony

That maps eerily well to microservices.

Modern distributed systems:

* Services own their state.* Services do not reach into other service databases.* Communication is contract-based.* Coordination emerges via messaging.

But autonomy without discipline produces fragmentation.

### Case Study: Early Microservices at Uber

Uber’s [early hypergrowth phase](https://medium.com/@archanachandrasekar563/the-story-of-ubers-journey-from-rest-to-grpc-to-domain-driven-architecture-bfa458940c25):

* Dozens → hundreds → thousands of services* Rapid team expansion* Weak governance* Inconsistent schema evolution* Service-to-service explosion

The result:

* Fragile dependency graph* Tight coupling through hidden contracts* Difficult incident containment

Uber eventually had to:

* Introduce stronger platform governance* Enforce API standardization* Invest heavily in observability and tooling

Leibnizian lesson: Autonomy requires internal perfection. Otherwise harmony collapses.

## 4. Being and Goodness Are Not Separate → Architecture Encodes Ethics

Hillman emphasizes that for Leibniz:

> Goodness is intrinsic to being. It is not imposed externally.

Translate that technically: if quality must be enforced externally, your architecture is weak.

Examples:

| External Enforcement      | Structural Goodness                   || - - - - - - - - - - - - - | - - - - - - - - - - - - - - - - - - - || Manual QA                 | Type systems & property-based testing || After-the-fact monitoring | Built-in observability                || Governance meetings       | Schema versioning rules               || Code review policing      | Clear module boundaries               |

### Case Study: Facebook’s “Move Fast” Era

Early Facebook optimized for:

* Speed of deployment* Feature velocity* Minimal friction

It worked — for growth. But structurally:

* Weak privacy boundaries* Data sharing patterns not constrained at architectural level* Ad-hoc data access

[Cambridge Analytica exposed](https://medium.com/@archanachandrasekar563/the-story-of-ubers-journey-from-rest-to-grpc-to-domain-driven-architecture-bfa458940c25) what happens when: Speed > structural constraint.

Goodness wasn’t intrinsic to system design. It relied on process and intention.

Leibniz would call this a metaphysical mismatch: the structure did not encode the values it claimed.

## 5. Virtue = Engineering Character Under Uncertainty

For Leibniz (following Aristotle), virtue is:

* Stable disposition* Toward rational excellence* Under variable conditions

In distributed systems, uncertainty is constant:

* Network partitions* Latency spikes* Hardware failures* Version mismatches* Traffic bursts

Virtue in engineering looks like:

* Designing for idempotency* Implementing retries with backoff* Circuit breakers* Failing fast instead of corrupting state* Writing rollback-safe migrations

### Case Study: AWS S3 Outage (2017)

An[ engineer executed a command with a broader scope than intended during maintenance](https://aws.amazon.com/message/41926/).

The system:

* Had hidden coupling between subsystems.* Depended on components assumed to be independent.* Failed beyond blast-radius expectations.

The problem wasn’t a bad engineer. It was systemic fragility.

Virtue at the individual level is insufficient if the system architecture amplifies small mistakes.

Leibniz’s insight: Moral order must be structural, not merely personal.

## 6. Local Optimization vs. Global Harmony

Leibniz rejects narrow egoism. True flourishing requires alignment with the whole system.

In distributed systems:

Local optimization often harms global performance.

Examples:

* A team optimizing DB queries by bypassing API contracts.* A service caching aggressively, increasing stale reads.* A team scaling vertically when horizontal rebalancing was needed.

### Case Study: Amazon’s “Two-Pizza Teams”

Amazon [structured teams as](https://aws.amazon.com/executive-insights/content/amazon-two-pizza-team/):

* Autonomous* API-contract-driven* Service owners

But with one rule: no shared databases.

**Why?**

Because shared state incentivizes local optimization at global cost. This is a structural mechanism for preventing egoistic architecture. Harmony is enforced at the boundary level.

## 7. Justice = Platform Governance

Hillman ends with Leibniz’s idea that justice is:

> Love guided by wisdom.

Technically:Justice = fairness + predictability + constraint.

In engineering orgs, that means:

* Stable versioning policies* Backward compatibility guarantees* Clear deprecation timelines* Transparent RFC processes* Incident accountability without blame culture

Justice prevents entropy.

### Failure Case: Unversioned Public APIs

Countless startups have:

* Shipped APIs without versioning.* Introduced breaking changes.* Destroyed integrator trust.

No justice at the interface level → ecosystem collapse.

Governance is not bureaucracy. It is system survival.

## 8. The Deep Structural Lesson

Leibniz’s metaphysics implies:

1. Structure determines behavior.2. Behavior determines value.3. Value determines flourishing.

In distributed systems:

1. Architecture determines behavior.2. Behavior determines reliability.3. Reliability determines trust.4. Trust determines long-term survival.

This is not metaphorical. It is causal.

### What Senior Engineers Should Extract From This

1. Encode values in architecture. Do not rely on intention.
2. Optimize globally, not locally. Measure systemic health.
3. Preserve invariants at all costs. Invariant drift = moral drift.
4. Design for human fallibility. Assume error. Contain blast radius.
5. Governance scales autonomy. Without constraints, freedom destroys coherence.

Leibniz believed we inhabit the best possible world because it maximizes harmony under constraints. Your production system is the same kind of object. Not perfect. But ideally: the most coherent version achievable under real-world trade-offs.

If your system keeps failing in surprising ways, the problem is not bad luck. It’s metaphysics.