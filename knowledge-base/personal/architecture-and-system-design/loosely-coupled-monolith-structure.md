# Loosely Coupled Monolith Structure

**Summary:** Transcript demonstrating the concrete project structure for a Loosely Coupled Monolith in .NET. It shows how to organize contracts, implementations and tests within Solution Folders and how to wire them up using a top-level ASP.NET Core host and a Worker service for messaging (CodeOpinion).

**Source:** [Solution & Project Structure of a Loosely Coupled Monolith](https://www.youtube.com/watch?v=-1DU9c95ERs) — CodeOpinion.

---

> **Note:** This is a transcript of a video. It may contain informal speech and lack text headers.

**Transcript:**

if you want to create a loosely coupled monolith that isn't a big ball of mud but are curious how that project and solution would be structured this video is for you in my video about creating a loosely coupled monolith which i will have a link in the description to that original video i use this slide to illustrate having kind of two top level processes a hp server which is going to be asp.net core and a message processor which will deal with messages from a message broker and below that actually having bounded contacts which are the blue that have three different projects actually inside them a contract project implementation and tests and each one of those each one of those bounded contexts having its own database...
(formatted for readability)