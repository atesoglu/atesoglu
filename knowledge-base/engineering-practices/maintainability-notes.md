# Maintainability Notes

Two critiques of common maintainability advice, kept together because they answer the same question: what makes code easier to change and debug?

## Clean Code Critique

**Source:** ["Clean Code" Is Bad. What Makes Code "Maintainable"? Part 1](https://www.youtube.com/watch?v=8ncQrGuunHY) — Internet of Bugs.

The central argument is that code is usually read **bottom-up while debugging**, not top-down like a book. A bug report gives you an error message, log line, or on-screen text; you search for it, find the relevant branch, and walk up the call stack. Code should make that path easy to follow.

Key implications:

- Excessive fragmentation into many tiny classes and methods can make navigation harder, not easier.
- Clever abstractions that hide decision context can turn a debuggable bug into a maze.
- The useful goal is **code isolation**: a change in one part of the system should not break unrelated parts.
- Hiding why a decision was made is dangerous. The rest of the program may need that context to diagnose a production issue.
- Unit tests and SOLID principles are not enough. A codebase can follow all of them and still be in a "whack-a-mole" state where every fix breaks something else.
- Maintainable code is not code that cannot have bugs. It is code that lets you find the bug, fix it, and add a test so it does not return.
- If a bug cannot be reproduced easily, that is a sign the code is hard to observe and navigate, not evidence that the bug does not matter.

## Five Common Design Mistakes

**Source:** [5 Mistakes That Make Your Code Unmaintainable](https://www.youtube.com/watch?v=G9FOfcVQNg4) — CodeOpinion.

The source identifies five common mistakes that make software hard to maintain:

1. **Invalid state and data consistency problems** caused by poor control over what changes state.
2. **Implicit code** where CRUD or entity operations hide the actual workflow.
3. **Useless indirection** that adds layers without reducing complexity.
4. **Playing the "what if" game** and building for hypothetical requirements.
5. **Not managing workflows properly**, so important business processes are scattered across the codebase.

The common thread is the same as the first critique: when the important decisions and workflow are hidden, debugging and change become expensive.
