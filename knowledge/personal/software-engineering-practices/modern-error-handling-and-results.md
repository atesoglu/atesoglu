# Modern Error Handling & The Result Pattern

**Summary:** A comprehensive guide on why and how to move from exception-driven flow control to the Result pattern in modern .NET applications.

---

## 1. The Problem with Exceptions for Flow Control

Exceptions are often described as "landmines" sprinkled throughout the code. When used for business logic (like validation failures), they introduce several issues:

- **Interface Dishonesty**: Method signatures like `bool CreateUser(...)` lie if they can throw a `ValidationException`. The caller has no idea it needs to catch anything.
- **Hidden Control Flow**: Exceptions act like a "GOTO" call, jumping straight to a middleware or a catch block, making it hard to trace the application flow.
- **Performance Cost**: Throwing and catching exceptions is significantly more expensive than returning objects. Benchmarks show a ~40-50% performance drop when spamming exceptions in high-load scenarios.

> [!TIP]
> **Performance Benchmark**: In high-load tests (using k6), APIs using the Result pattern handled ~34k requests/sec, while those throwing exceptions for validation dropped to ~19k requests/sec.

---

## 2. The Golden Rule of Errors vs. Exceptions

A simple heuristic for deciding when to throw or return:

- **Errors (Return)**: Use for expected, recoverable outcomes (e.g., validation failed, user not found, unauthorized). These are for **users** and **consuming code**.
- **Exceptions (Throw)**: Use for truly exceptional, unrecoverable situations (e.g., database connection down, out of memory, disk full). These are for **developers** and **sysadmins**.

---

## 3. Implementing the Result Pattern (C# 12+)

The Result pattern encapsulates the outcome of an operation (Success or Failure) into a single object.

### Basic Result Implementation
Using modern C# features like Primary Constructors and `switch` expressions:

```csharp
public readonly struct Result<TValue>
{
    private readonly TValue? _value;
    private readonly Exception? _error;

    public bool IsSuccess => _error is null;
    public bool IsFailure => !IsSuccess;

    private Result(TValue value) => _value = value;
    private Result(Exception error) => _error = error;

    public static implicit operator Result<TValue>(TValue value) => new(value);
    public static implicit operator Result<TValue>(Exception error) => new(error);

    public TResult Match<TResult>(
        Func<TValue, TResult> onSuccess,
        Func<Exception, TResult> onFailure) =>
        IsSuccess ? onSuccess(_value!) : onFailure(_error!);
}
```

### Usage in a Service
```csharp
public async Task<Result<Customer>> CreateAsync(CreateCustomerRequest request)
{
    var validationResult = await _validator.ValidateAsync(request);
    if (!validationResult.IsValid)
    {
        return new ValidationException(validationResult.Errors); // Implicitly converted to Result
    }

    var customer = request.ToDomain();
    await _repository.AddAsync(customer);
    
    return customer; // Implicitly converted to Result
}
```

### Usage in a Controller
```csharp
[HttpPost]
public async Task<IResult> Create(CreateCustomerRequest request)
{
    var result = await _service.CreateAsync(request);

    return result.Match(
        customer => Results.Created($"/customers/{customer.Id}", customer),
        error => error switch
        {
            ValidationException ve => Results.BadRequest(ve.ToProblemDetails()),
            _ => Results.InternalServerError()
        });
}
```

---

## 4. Pragmatic Trade-offs

While the Result pattern improves clarity and performance, consider these trade-offs:

- **Verbosity**: It requires more boilerplate in method signatures and caller handling (e.g., `.Match()`).
- **Overkill for Private Methods**: For small, internal helper methods where logic is simple, returning a nullable or specialized type might be sufficient.
- **Library Selection**: For professional production apps, consider using well-tested libraries like `OneOf` (for Discriminated Unions) or `FluentResults`.

---

**References:**
- Based on insights from Derek Martin (CodeOpinion) and Nick Chapsas.
