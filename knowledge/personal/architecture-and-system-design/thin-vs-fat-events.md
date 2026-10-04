# Thin vs. Fat Events

**Summary:** Transcript discussing the trade-offs between Thin Events (IDs only) and Fat Events (full state). It warns against "Delta Events" that encourage coupling and argues for Thin Events where consumers fetch data from their own context, not the producer (CodeOpinion).

**Source:** [Thin or Fat Events? Are your boundaries right?](https://www.youtube.com/watch?v=vDtK-ccQWkw) — CodeOpinion.

---

> **Note:** This is a transcript of a video. It may contain informal speech and lack text headers.

**Transcript:**

thin events versus fat events in adventure of an architecture you're likely going to end up with one of the two in most situations i recommend thin events but here's how you do it without synchronously calling the producer to get extra data hey everybody it's derek martin from codopinion.com if you're new to my channel i post videos on software architecture and design and net so if you're into those topics make sure to subscribe so let's start talking about fat events so i'm in my loosely coupled monolith that i've been using uh for all my other videos and the source for this is available on github i have a link in the description but i have my order placed event and i've added two new properties shipping address and billing address of the address type now the thing with fat events is that they generally don't start out fat generally they end up starting out fairly thin but you keep adding stuff as consumers get added...
(formatted for readability)