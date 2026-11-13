# Tech Lead / Team Lead

The technical compass of the team. Accountable for the architecture, quality and technical growth of a single team.

## Role Expectations

### 1. Core Accountability
The Tech Lead (TL) ensures that the team ships high-quality, scalable code that meets business needs. They are the "Bridge" between the Product requirements and the technical implementation.

### 2. Impact Areas

#### 🏛️ Architecture & Quality (Primary Focus)
- **Technical Vision**: Defines the 3-6 month technical roadmap for the team.
- **Standards & Best Practices**: Sets the bar for code quality, testing rituals and logging.
- **System Integrity**: Proactively identifies and manages technical debt and security risks.

#### 👥 Technical Leadership (Multiplier Effect)
- **Peer Development**: Coaches Senior engineers on architectural thinking.
- **High-Stakes Spikes**: Leads the implementation of the most complex or risky architectural changes.
- **Technical Facilitation**: Leads design reviews and resolves technical deadlocks within the team.

#### ⚙️ Delivery Partnership
- **Product Brokerage**: Partners with the EM and PM to ensure the backlog is technically feasible and well-groomed.
- **Risk Management**: Flags technical blockers early and proposes pragmatic "Plan B" options.
- **DORA Stewardship**: Accountable for the team's technical efficiency and reliability metrics.

### 3. Essential Resources for the Role
- [Modern Error Handling & Results](../software-engineering-practices/modern-error-handling-and-results.md)
- [Clean Architecture and DDD](../software-engineering-practices/clean-architecture-and-ddd.md)
- [Resilience & Stability Patterns](../architecture-and-system-design/resiliency-and-stability-patterns.md)
- [Estimation Guidance](../processes-operations/proposal-and-estimation-guide.md#8-estimation-guidance)
- [Tech Lead Onboarding](#first-30-days)
- [Tech Lead Long-Term Strategy](#long-term-success)

## First 30 Days

*Transitioning from "Lead Contributor" to "Technical Synergist."*

### 1. Days 1–10: Assessing the Team's Technical Compass
- [ ] **Architecture Audit**: Review the team's current technical designs. Identify one critical dependency or "fragile" area.
- [ ] **Lead 1:1s**: Meet with your Manager (EM) and your Senior engineers. Ask: "What technical decision do we regret the most right now?"
- [ ] **Developer Experience (DX) Check**: Walk through the "local-to-production" flow yourself. Identify where developers spend the most "wasted" time.

### 2. Days 11–20: Brokering Agreements
- [ ] **Establish the RFC Process**: Ensure there is a lightweight way for the team to propose and review architectural changes.
- [ ] **Standardize the "Done"**: Define what high-quality code looks like for the team (Testing, Logging, Documentation).
- [ ] **Cross-Team Sync**: Meet with other Tech Leads in your domain. Understand the shared platform roadmap.

### 3. Days 21–30: Scaling Through Others
- [ ] **Delegate a Design**: Assign a medium-sized project's technical ownership to a Senior engineer. Focus on guiding their design rather than writing it.
- [ ] **The First "Tech-Debt" Win**: Negotiate a specific % of the sprint to tackle a technical bottleneck that you identified in your first 10 days.
- [ ] **Define the Technical North Star**: Draft a simple "Technical Vision" for the team (3-6 month view) and get team buy-in.

### 4. Key Behavioral Shift
- **From Direct Execution to Strategic "Gluing"**: Your success is now the *combined* technical output of the team.
- **Synthesizing over Dictating**: Facilitate technical discussions to find the best answer, rather than always providing it yourself.
- **The "High-Level" IC**: You should still write code, but your focus is on the most difficult, cross-cutting spikes or critical system paths.

## Long-Term Success

*Growing the team's technical maturity and influence over 12 months.*

### 1. The 12-Month Roadmap

- **3–6 Months**: **Operational Consistency**. The team's CI/CD is robust, the "Golden Path" is clear and technical debt is managed predictably. 
- **6–12 Months**: **Architectural Evolution**. You have successfully led a major system improvement (e.g., modularization or performance overhaul). You are a trusted voice in the domain's Architecture Guild.
- **1 Year+**: **Strategic Multiplying**. The team produces Senior-level designs with minimal steer from you. You are influencing the organization's technical standards (Staff/Principal level impact).

### 2. Success, Failure and Recovery

| The Path to Success | The Path to Failure | The Crisis Recovery |
| :--- | :--- | :--- |
| **Pragmatic Generalist**: You choose the right tool for the job, even if it's not the one you know best. | **The Tech Dictator**: You make all architectural decisions in a vacuum, killing team autonomy. | **The "Blameless" Stabilizer**: You lead the resolution of a production crisis without finger-pointing. |
| **Architectural Mentor**: You teach your EMs and Seniors how to think like architects. | **The "Fix-it" Hero**: You save the day by working 80 hours a week instead of fixing the system flaws. | **The Pattern Recognition**: You identify a recurring bug class and implement a systemic fix (e.g., a custom lint rule). |

### 3. The Promotion Path: Toward Principal Engineer or EM
To move to the next level (Principal IC or EM Management), you must demonstrate:
- **Organizational Leverage**: You've created a tool or pattern used by multiple teams.
- **Business Translation**: You can explain the revenue impact of technical debt to Product and Finance.
- **Succession Planning**: You have at least one Senior engineer ready to step into the Tech Lead role.
- **Continuous Improvement**: The team's DORA metrics have improved by 15-20% under your technical guidance.
