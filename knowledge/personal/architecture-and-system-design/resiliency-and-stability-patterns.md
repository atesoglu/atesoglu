# Resilience and Stability Patterns

**Summary:** Essential patterns for building stable, self-healing distributed systems.

---

## 1. Why Resilience Matters
In a distributed system, failure is inevitable. Networks fail, third-party APIs go down and databases become slow. Resilience patterns reduce the chance that a failure in one component becomes a cascading failure across the entire system.

---

## 2. Core Stability Patterns

### Circuit Breaker 🔌
Prevents an application from repeatedly trying to execute an operation that is likely to fail.
- **Closed**: Requests flow normally. If failure threshold is reached, it "trips" to Open.
- **Open**: Requests fail immediately without attempting the operation. This gives the system time to recover.
- **Half-Open**: After a timeout, it allows a limited number of test requests. If they succeed, it closes back to normal.

### Bulkheads 🚢
Inspired by ship design, where a hull is divided into watertight compartments.
- **Concept**: Split your service's resources (e.g., thread pools, memory) into distinct "pockets."
- **Benefit**: If one pool (e.g., for a slow third-party API) is exhausted, other parts of the system remain operational.

### Retry with Jitter 🔄
Automatically retrying a failed operation.
- **Exponential Backoff**: Increasing the wait time between retries (e.g., 1s, 2s, 4s).
- **Jitter**: Adding a small random delay to the wait time.
- **Why?**: Prevents "thundering herd" problems where many clients retry at the exact same millisecond, overwhelming the recovering service.

---

## 3. Implementation in .NET (Polly)

Polly is a widely used resilience library for .NET.

```csharp
// Define a combined strategy
var pipeline = new ResiliencePipelineBuilder()
    .AddRetry(new RetryStrategyOptions
    {
        MaxRetryAttempts = 3,
        BackoffType = DelayBackoffType.Exponential,
        UseJitter = true
    })
    .AddCircuitBreaker(new CircuitBreakerStrategyOptions
    {
        FailureRatio = 0.5,
        SamplingDuration = TimeSpan.FromSeconds(10),
        MinimumThroughput = 8
    })
    .Build();

// Execute an operation
await pipeline.ExecuteAsync(async cancellationToken =>
{
    await _externalService.CallAsync(cancellationToken);
});
```

---

## 4. Best Practices
- **Apply at the Boundary**: Use resilience patterns whenever you cross a network or process boundary.
- **Monitor the Breakers**: Always log and monitor when a circuit breaker trips so you are alerted to underlying system degradation.
- **Fail Fast**: If a bulkhead is full or a circuit is open, fail fast to preserve resources for other requests.
