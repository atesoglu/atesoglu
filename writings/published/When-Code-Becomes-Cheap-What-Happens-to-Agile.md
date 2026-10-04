# When Code Becomes Cheap, What Happens to Agile?

*After six months of AI-assisted development, I’m starting to wonder whether our biggest software bottleneck is no longer engineering…*

## When Code Becomes Cheap, What Happens to Agile?

### After six months of AI-assisted development, I’m starting to wonder whether our biggest software bottleneck is no longer engineering capacity but human understanding.

If you are building software in your business, your development team is changing faster than you probably realize. It isn’t necessarily the people who are changing but it is the nature of the work itself.

Over the past six months I’ve watched something shift in a way that I didn’t fully appreciate at first: **The bottleneck in software development is moving, fast.**

For decades, we largely operated on a simple model:

> Requirements → developers write code → developers review code → software ships.

Now we increasingly have:

> Intent → specification → AI generates code → AI generates tests → engineers sometimes verify architecture and behavior → software ships.

That might look like a productivity improvement. Indeed it is but it is also something much bigger because if AI dramatically reduces the cost of producing software, then eventually we have to ask a fairly uncomfortable question: **Are we still organizing software development around the same assumptions that existed before AI?**

And that leads to an even more uncomfortable question: **What happens to Agile when writing the code is no longer the expensive part?**

## Agile Solved a Very Real Problem

Before criticizing Agile, it is worth remembering why it existed in the first place. In February 2001, seventeen software practitioners met at Snowbird, Utah, to discuss alternatives to heavyweight, documentation-driven development processes. The result was the Agile Manifesto. The problem they were responding to was familiar; software projects were spending enormous amounts of time trying to specify everything in advance, requirements documents grew, plans became increasingly detailed, contracts became increasingly rigid, teams spent months building software before customers had meaningful opportunities to interact with it and then reality happened. Customers changed their minds or the markets changed or the requirements were misunderstood or all-of-the-above. Things that looked sensible on paper turned out to be useless when someone actually used them. Agile’s answer was beautifully simple:

> Build → Show it to people → Learn → Change direction → Build again.

The manifesto explicitly valued working software over comprehensive documentation and responding to change over following a plan. Its principles emphasized frequent delivery, collaboration between business and developers, and allowing requirements and designs to emerge through the work itself. This wasn’t an anti-documentation manifesto but it was an **anti-documentation-as-a-substitute-for-learning** manifesto.

And that distinction matters because Agile was fundamentally about managing **uncertainty**. We don’t know exactly what the customer wants and most of the time we don’t know exactly what the market will do or even they cannot properly emphasize what they want in the first place. We don’t know exactly which solution will work so let’s shorten the feedback loop and that was a very good idea. And for a long time, it made a lot of sense.

## Then AI Changed the Bottleneck

Fast-forward to today.

AI coding tools have changed the economics of implementation. (And not only the new implementations but also [refactorings and modernizations too](https://x.com/DamianEdwards/status/2079303235253502221).)

According to Stack Overflow’s 2025 Developer Survey, 84% of respondents said they were using or planning to use AI tools in their development process, while 51% of professional developers reported using them daily. At the same time, 46% said they actively distrust the accuracy of AI output, compared with 33% who trust it. That combination is fascinating, people are using AI and we will only see those numbers will go up, no matter what the underlying trust issues are.

They believe it makes them faster and they don’t necessarily trust what it produces. That sounds contradictory until you actually work with these systems but the AI is incredibly good at producing *something *and the difficult part is increasingly determining whether that something is actually what you meant.

I’ve seen this shift firsthand. Code now arrives faster than humans can comfortably review it; a developer can ask Copilot, Claude, Cursor or another agent to implement a feature, run the tests, fix the failures, refactor the implementation and produce a pull request. I’ve even seen some examples of using an agent to reply to a feedback received in a PR.

The old bottleneck was: **How quickly can we write this code?**

The new bottleneck is often: **How quickly can we understand whether this code represents the right decision?**

That’s a fundamentally different problem.

## The Migration of Quality Upstream

Historically, much of our quality process happened downstream; a developer wrote code, another developer reviewed the pull request and if the code looked good and the tests passed, we shipped it. But AI changes the volume of code entering that pipeline and the machine can produce implementation faster than the human organization can absorb it so quality starts moving upstream. Instead of relying primarily on code review, we increasingly need to improve the things that happen **before the code exists**.

That means:

- clearer specifications,
- better acceptance criteria,
- explicit business rules,
- state machines,
- decision tables,
- stronger automated tests,
- architectural constraints,
- better system context.

This is where things get particularly strange, as some of the things Agile taught us to keep lightweight are becoming useful again. Not because Agile was wrong (perhaps, it’s definitely obsolete, but still…). Because **the machine has changed the nature of the problem.**

## The Documentation Paradox

And this is perhaps the most surprising thing I’ve noticed. **AI coding is pushing teams back toward structured requirements, explicit specifications, state machines, decision tables and increasingly detailed PRDs; precisely the kinds of upfront, formal documentation that the Agile movement emerged partly in reaction to.**

That sounds like we’re going backwards and agile taught us that we shouldn’t spend months trying to specify software before we build it. We should build something small, learn from it and adapt, yet, now, when we ask an AI agent to build something, we’re discovering that ambiguity has a cost.

A human developer can take a sentence like:

> *“Allow users to cancel their orders.”*

and fill in dozens of missing details from experience but an AI agent can’t reliably do that.

- *Can an order be cancelled after payment?*
- *After shipment?*
- *What happens to the refund?*
- *What if we already received a chargeback?*
- *What if cancellation happens twice?*
- *What if the payment provider is unavailable?*
- *What if 50,000 orders are cancelled simultaneously?*

Suddenly, the state machine isn’t bureaucracy, the decision table isn’t over-engineering and the acceptance criteria aren’t administrative overhead. They’re **instructions to the machine**. And this creates one of the strangest paradoxes of AI-assisted development:

> **Agile tried to make software development less dependent on comprehensive specifications. AI may be making precise specifications valuable again.**

I don’t think this necessarily means Agile was completely (to a certain level but not completely) wrong. The important distinction is *why* we’re writing the specification. In traditional, heavyweight development, we might create a detailed specification because we wanted to define the entire project before implementation but in AI-assisted development, we may create a detailed specification because **the implementation can now happen almost instantly once the intent is unambiguous.**

Those are very different things. The first says:

> *“Let’s figure everything out before we start.”*

The second says:

> **“Let’s make the next thing we ask the machine to do precise enough that we can trust the result.”**

That distinction might become one of the defining characteristics of AI-native software development.

## The “Cheating Agent” Problem

Unfortunately, precise specifications don’t solve everything and no matter how much guardrails you have in your agents/skills/rules/*.md files, most of the time they create another problem:

> **How do we know the specification itself is correct?**

AI agents are extremely good at satisfying the immediate objective you give them, unfortunately, sometimes they are also extremely good at cheating, for example just give an agent a failing test and ask it to make the test pass; it may fix the underlying problem or it may find a way around the test. Give it a requirement and ask it to implement the feature, it may build the feature or it may construct the narrowest interpretation of the requirement that passes the available checks. This is one reason I don’t think “*AI writes the code and tests itself*” is sufficient and I’ve seen many examples that I was right to do so.

You can end up with:

> *AI writes code → AI writes tests → AI runs tests → AI declares success.*

But passing a test doesn’t necessarily mean satisfying the business requirement as the system can be internally consistent and still be completely wrong. This is why I increasingly think we need **adversarial verification**, not just an agent that tries to make the system work but an agent that tries to break it. A chaos monkey, Agent Smith, an “angry agent,” if you will.

Its job is to ask:

- *What assumption are we making?*
- *What happens at the boundary?*
- *What happens under load?*
- *What if the user behaves unexpectedly?*
- *What if the external service fails?*
- *What if this requirement contradicts another requirement?*

The point isn’t to make AI less helpful but it is to prevent an AI optimized for completion from becoming an AI optimized for confirmation.

## The New Engineering Job: Supervision

This is also changing the composition of engineering work as I’ve noticed a particularly interesting split across experience levels.

- **Senior engineers: **More architectural and supervisory responsibility; increasingly reviewing agent-generated implementation rather than writing every line.
- **Mid-level engineers: **Need to transition from syntax and implementation toward intent, decomposition, specifications and agent orchestration.
- **Junior engineers: **Can become productive remarkably quickly, but may lack the system context required to recognize subtle architectural or operational mistakes

This creates a new category of engineering work, I think of it as **supervisory engineering**.

It includes:

1. Breaking large problems into agent-sized tasks.
2. Providing the right context.
3. Defining constraints.
4. Writing precise specifications.
5. Designing verification strategies.
6. Reviewing architectural consequences.
7. Knowing when the agent should stop.
8. Understanding when the generated implementation is technically correct but conceptually wrong.

This isn’t necessarily less engineering on the contrary, in some ways, it is more engineering as we’re moving from:

> **“How do I implement this?”**

toward:

> **“What exactly should exist, why should it exist, and how can I prove that it does what we intended?”**

## The Problem With Code Arriving Too Quickly

There is another consequence that isn’t discussed enough. When implementation becomes faster, the rest of the organization doesn’t automatically become faster. Imagine a developer used to producing one meaningful pull request a day and now an AI agent can produce five. The developer hasn’t suddenly acquired five times the capacity to understand those changes and the reviewer hasn’t acquired five times the capacity to review them. QA hasn’t necessarily acquired five times the capacity to validate them. Operations hasn’t acquired five times the capacity to deal with production failures and the result can simply be a bigger queue. This is one reason the AI productivity story is more complicated than “*developers can now code faster*”.

DORA’s research on AI-assisted software development has identified a similar tension: AI adoption can increase individual productivity while creating problems elsewhere in the delivery system, including larger change batches and reduced delivery throughput or stability in some environments. In other words: **AI doesn’t automatically remove bottlenecks, it moves them. **And that may be the single most important thing for engineering leaders to understand.

## Is Agile Still the Right Operating System?

This is where my experience with AI coding led me somewhere I didn’t expect. If specifications are becoming more important again, aren’t we moving backwards? Didn’t Agile specifically emerge as a reaction against heavyweight requirements and documentation? Didn’t Agile teach us to build something small, get feedback, and avoid trying to specify the entire system before we understood it?

Yes, and I still believe in that principle but perhaps we’ve been asking the wrong question. The question isn’t:

> **Agile or specifications?**

The question is:

> **What is the right size and role of a specification when implementation is nearly instantaneous?**

Because there is a huge difference between:

> *“Let’s write a 150-page specification before we build anything”.*

and:

> *“Let’s define the next 20 minutes of machine-executable work precisely enough that the agent cannot reasonably misunderstand us”.*

The first is waterfall and the second might actually be **more Agile than what many organizations call Agile today.**

## Maybe Agile Became a Management System

This is the part I’m still wrestling with. Agile started as a reaction against heavyweight software processes but over the years, Agile itself became a process as the companies built entire management systems around it:

- Daily stand-ups.
- Backlogs.
- Epics.
- Daily stand-ups.
- Stories.
- Story points.
- Daily stand-ups.
- Sprints.
- Daily stand-ups.
- Velocity.
- Planning.
- Daily stand-ups.
- Refinement.
- Retrospectives.
- Daily stand-ups.
- Roadmaps.
- Daily stand-ups.
- Quarterly commitments.
- Daily stand-ups.
- Dashboards.
- Daily stand-ups.

Eventually, “Agile” became something that organizations could buy, certify, implement and measure and I wonder if some of this survived because it solves a problem that has little to do with software engineering. To me, sometimes it feels like we’ve created all these processes and ceremonies, just to make sure that product owners and scrum masters can understand that developers are actually doing their job.

At the same time; **management wants predictability **but the software development is inherently unpredictable, due to its nature but Agile created (sometimes, not always) a useful compromise. You can’t necessarily tell management exactly what will be delivered six months from now. But you can say:

> *“This is what we’re working on this sprint.”*

And then measure what happened as that’s useful but it raises an uncomfortable question: **Is Agile still primarily optimizing software development/delivery, or are we optimizing the management of software development teams?**

Because those aren’t necessarily the same thing.

## What Happens When Velocity Stops Meaning Anything?

Imagine an AI agent can implement ten Jira tickets overnight. **What does velocity mean then?**

Imagine a senior engineer can generate five architectural alternatives in an afternoon. **What does estimation mean?**

Imagine the cost of implementing a feature falls from several days to several hours. **Should we still organize the work around developer capacity? Or should we organize it around uncertainty?**

These aren’t theoretical questions and if the scarce resource is no longer typing code, then measuring how much code a team can produce becomes increasingly disconnected from the thing we actually care about.

Perhaps we need to measure something else; not how much code was produced, not how many tickets were closed, not even necessarily how many features were shipped but perhaps the more interesting measurements become:

- **How quickly can we grasp/adapt?**
- **How quickly can we validate an assumption?**
- **How reliably can we change the system?**
- **How much of our system’s behavior can we verify automatically?**
- **How much human attention does each change consume?**
- **How quickly and reliably can we refactor/modernize a legacy system and drop out the baggage?**

Those are very different questions from traditional Agile metrics.

## The Loss of Tribal Knowledge

There is another problem that becomes much more important in this world: **context**. Senior engineers carry enormous amounts of undocumented knowledge; for example they know *that strange cron job*, they remember the *outage from three years ago*, they know why nobody touches *a particular database index* or they remember that the apparently stupid-looking retry mechanism exists because a payment provider once behaved catastrophically.

That knowledge isn’t necessarily in the documentation but it’s in people’s heads. And nothing’s wrong with it as it’s impossible to document everything but the real problem is, AI doesn’t and cannot automatically inherit it.

Consider a late-night production outage; an AI agent sees a `503 Service Unavailable` error and reads the standard operational documentation and then it recommends restarting the service. The service comes back. Twenty minutes later, it crashes again. A senior engineer might immediately remember that this happened before: a background job was exhausting the database connection pool or OS thread pool.

The difference wasn’t access to documentation, it was **context**. It was, **not having a witness to everything you’ve been experiencing as a company for the last couple of years** (And you can provide this custodians approach only with **junior engineers **by the way but [that’s another article](https://medium.com/@atesoglu/your-2027-strategy-needs-fewer-tokens-and-more-juniors-f4cdaf84921c)).

If you think humans are much more expensive and if you wanna go fully-blown AI way, then I increasingly think organizations need what I jokingly call an **agent-subconscious, **not merely documentation; a living body of system knowledge containing:

- architectural decisions,
- incident histories,
- operational runbooks,
- known failure modes,
- business exceptions,
- rejected approaches,
- unusual dependencies,
- historical context,
- “don’t do this because we already tried it” knowledge.

An AI agent that knows the syntax of your system isn’t enough. It needs to know **why the system is the way it is. It has to have the absence context.**

## The GPU Moment for Software Engineering

There is an analogy I keep coming back to. In the early days of 3D graphics, programmers had to perform enormous amounts of low-level computation themselves and then specialized graphics hardware emerged, the abstraction changed but developers didn’t stop creating graphics, they moved up the abstraction stack. The interesting question is whether AI is doing something similar to software development.

For decades:

> **Human → syntax → code → software**

Increasingly:

> **Human → intent/specification → agent → code → software**

The code doesn’t disappear but it becomes less of the scarce intellectual artifact.

- Architecture matters more.
- Specifications matter more.
- Verification matters more.
- System design matters more.
- Context matters more.
- And more importantly human judgment matters more.

Thoughtworks has begun describing spec-driven development as an emerging AI-assisted coding approach in which structured functional specifications are broken into smaller solutions and tasks before implementation. That doesn’t mean the industry has settled on a new methodology but it means we’re starting to see the shape of one.

## So, Is Agile Dead?

No, (but I wish) and I don’t think that should be the conclusion. The best ideas in Agile may actually become **more** important in an AI-native world.

- Short feedback loops.
- Working software.
- Customer collaboration.
- Responding to change.
- Small increments.
- Continuous improvement.

*Those ideas* aren’t obsolete. What may be obsolete is assuming that the developer’s scarce resource is **the ability to produce code **and that assumption is increasingly questionable. Perhaps the future looks more like:

> **Human intent → small precise specification → AI implementation → automated verification → adversarial review → real-world feedback → refined specification**

That still has the Agile feedback loop but it isn’t necessarily Scrum, it isn’t necessarily story points, it isn’t necessarily two-week sprints and it certainly doesn’t require a developer to manually type every line of code.

## If We Invented Software Development Today…

I don’t want to replace Agile with another methodology because I don’t have a proper replacement that would satisfy most of the conditions and plus, we’ve had enough methodologies but instead, I’d like us to ask a more fundamental question:

> **If we were designing software development from scratch today, knowing what AI can do, would we invent Agile in its current form?**

I’m not sure we would. Agile emerged in a world where implementation was expensive, feedback was slow, and requirements were uncertain and AI is creating a world where implementation can be extraordinarily cheap and fast, while **correctness, context, architecture and intent remain expensive. **That changes the economics and when the economics change, the process eventually has to change too.

Maybe the future isn’t:

> **Waterfall → Agile → AI Agile.**

Maybe it is something more fundamental:

> **Code becomes cheap.Specifications become executable.Tests become continuous.Context becomes infrastructure.Verification becomes a first-class engineering discipline.And human attention becomes the scarce resource.**

That’s the shift I’ve seen over the last six months and I started by thinking AI was going to make developers faster. Now I’m increasingly convinced that the more interesting thing happening is that **AI is changing what “developer” even means** and if that’s true, perhaps we shouldn’t spend the next ten years teaching AI to fit neatly into our existing software-development process. Perhaps we should ask whether **the process itself is now the thing that needs to be redesigned.**