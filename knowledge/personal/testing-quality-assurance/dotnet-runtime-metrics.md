# .NET Runtime Metrics

A reference for the main .NET runtime metrics surfaced by tools such as Rider during benchmarks.

## Process and GC

- CPU usage: current process CPU consumption.
- Working set: physical memory currently resident for the process, including managed and native memory and potentially shared pages. Use private working set or process-specific counters when that distinction matters.
- GC heap size and committed bytes: managed heap usage and memory committed by the runtime; they are not the same as total process memory.
- Gen 0, Gen 1, and Gen 2 sizes and counts: current generation sizes, collection frequency, and object-survival patterns. They do not by themselves prove a leak or a performance problem.
- GC fragmentation: free space between managed objects that may reduce allocation efficiency.
- Allocation rate: managed memory allocated over time, usually expressed as bytes per second.
- Percentage of time in GC and GC pause time: the runtime cost of garbage collection.
- LOH size: memory used by large objects. The commonly cited roughly 85 KB threshold is an implementation detail and should not be treated as a universal application rule.
- POH size: pinned objects that cannot be moved by the GC.

## JIT, Threads, and Synchronization

- IL bytes and methods jitted, plus JIT time: compilation activity.
- ThreadPool thread count: worker threads currently available or active; queue length: work items waiting to run; completed work: cumulative work completed since process start.
- Monitor lock contention: waiting caused by lock contention.
- Active timers: timers registered by the process.
- Exception count: exceptions observed by the relevant runtime counter. Treat it as a signal to investigate; counter semantics can vary by runtime version and tool.

## Interpretation

Interpret metrics in the context of a representative workload and a defined measurement window. Compare allocation rate, GC pause time, CPU, latency, throughput, and memory together. A zero GC count or low allocation rate during an idle measurement says little about a completed benchmark, and a high counter is not automatically a defect without a user-visible impact or a baseline comparison.

## Source

The original mixed notes are preserved in [quick-notes-source.md](../../drafts/quick-notes-source.md).
