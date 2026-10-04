# Clean Architecture + DDD: A Practical Guide to Project Structure and Validation

```
DDD is about entropy. It uses natural language to increase the information of code. This facilitates modeling reality.
```


If you're building a .NET/C# solution using Clean Architecture and Domain-Driven Design (DDD), one of the first challenges you'll face is deciding what goes where. The Infrastructure and API layers are usually straightforward, but the boundary between Domain and Application layers can be fuzzy. Let's clear that up.

Clean Architecture describes dependency and boundary organization; DDD is a way to model business complexity. They can be used together, but DDD is not required for every feature. For simpler CRUD-oriented workflows, see [Transaction Script vs DDD](../architecture-and-system-design/transaction-script-vs-ddd.md) before introducing aggregates or rich domain models.

## The Domain Layer: Your Pure Business Logic

The Domain layer is the heart of your application. It contains **pure business logic** with zero dependencies on external concerns. Think of it this way: if you deleted every other project in your solution, your Domain should still compile and make complete sense on its own.

### What Belongs in Domain?

- **Entities** - Core business objects with identity (`Order`, `Customer`, `Product`)
- **Value Objects** - Immutable objects defined by their values (`Money`, `Address`, `Email`)
- **Domain Events** - Things that happened in your domain (`OrderPlacedEvent`, `CustomerRegisteredEvent`)
- **Aggregates & Aggregate Roots** - Clusters of entities/value objects treated as a single unit
- **Domain Exceptions** - Business rule violations (`InsufficientStockException`)
- **Enums and Domain Constants** - Business-related enumerations
- **Repository Interfaces** - Just the contracts, not implementations
- **Domain Services** - Business logic that doesn't naturally fit in an entity (e.g., pricing calculations involving multiple entities)
- **Specifications** - Business rules for querying/filtering (optional pattern)

### Example: A Domain Entity

```csharp
public class Order : Entity
{
    private readonly List<OrderLineItem> _lineItems = new();
    
    public OrderId Id { get; private set; }
    public CustomerId CustomerId { get; private set; }
    public OrderStatus Status { get; private set; }
    public IReadOnlyCollection<OrderLineItem> LineItems => _lineItems.AsReadOnly();
    
    private Order() { } // For EF Core
    
    public static Result<Order> Create(CustomerId customerId)
    {
        if (customerId == null)
            return Result.Failure<Order>("Customer ID is required");
            
        var order = new Order
        {
            Id = OrderId.New(),
            CustomerId = customerId,
            Status = OrderStatus.Pending
        };
        
        return Result.Success(order);
    }
    
    public Result AddLineItem(Product product, int quantity)
    {
        if (quantity <= 0)
            return Result.Failure("Quantity must be positive");
            
        if (product.Stock < quantity)
            return Result.Failure("Insufficient stock");
            
        var lineItem = new OrderLineItem(product.Id, product.Price, quantity);
        _lineItems.Add(lineItem);
        
        return Result.Success();
    }
}
```

## The Application Layer: Orchestrating Your Domain

The Application layer **coordinates** domain objects to fulfill use cases. It knows about the Domain but has no knowledge of Infrastructure details. It defines contracts that Infrastructure will implement.

### What Belongs in Application?

- **Use Cases / Command Handlers** - Orchestrates domain objects to fulfill requests (`CreateOrderHandler`, `RegisterCustomerUseCase`)
- **DTOs** - Data Transfer Objects for moving data in/out of your application
- **Commands & Queries** - CQRS-style request objects (`CreateOrderCommand`, `GetOrderByIdQuery`)
- **Interfaces for Infrastructure** - Contracts like `IEmailService`, `IFileStorage`, `IPaymentGateway`
- **Application Exceptions** - Application-level errors (`ValidationException`, `NotFoundException`)
- **Mapping Profiles** - AutoMapper or similar configurations
- **Validators** - FluentValidation rules for commands/queries
- **Application Events** - Cross-cutting concerns that aren't pure domain events

### Example: An Application Use Case

```csharp
public class CreateOrderHandler : IRequestHandler<CreateOrderCommand, Result<OrderDto>>
{
    private readonly ICustomerRepository _customerRepository;
    private readonly IOrderRepository _orderRepository;
    private readonly IProductRepository _productRepository;
    private readonly IUnitOfWork _unitOfWork;
    
    public CreateOrderHandler(
        ICustomerRepository customerRepository,
        IOrderRepository orderRepository,
        IProductRepository productRepository,
        IUnitOfWork unitOfWork)
    {
        _customerRepository = customerRepository;
        _orderRepository = orderRepository;
        _productRepository = productRepository;
        _unitOfWork = unitOfWork;
    }
    
    public async Task<Result<OrderDto>> Handle(CreateOrderCommand command, CancellationToken cancellationToken)
    {
        // Get customer
        var customer = await _customerRepository.GetByIdAsync(command.CustomerId);
        if (customer == null)
            return Result.Failure<OrderDto>("Customer not found");
        
        // Create order using domain factory method
        var orderResult = Order.Create(customer.Id);
        if (orderResult.IsFailure)
            return Result.Failure<OrderDto>(orderResult.Error);
            
        var order = orderResult.Value;
        
        // Add line items
        foreach (var item in command.Items)
        {
            var product = await _productRepository.GetByIdAsync(item.ProductId);
            if (product == null)
                return Result.Failure<OrderDto>($"Product {item.ProductId} not found");
                
            var addResult = order.AddLineItem(product, item.Quantity);
            if (addResult.IsFailure)
                return Result.Failure<OrderDto>(addResult.Error);
        }
        
        // Save
        await _orderRepository.AddAsync(order);
        await _unitOfWork.SaveChangesAsync(cancellationToken);
        
        return Result.Success(OrderDto.FromOrder(order));
    }
}
```

## Naming Conventions: Avoiding Confusion

Having "services" in both Domain and Application layers can be confusing. Here's a clearer naming approach:

- **Domain Services** - Keep this name for business logic across multiple entities
- **Application Layer** - Use one of these:
  - **Handlers** (especially with CQRS/MediatR) - `CreateOrderHandler`
  - **Use Cases** - `CreateOrderUseCase` (very explicit)
  - **Orchestrators** - Also valid, though a bit heavy

Pick one and stay consistent throughout your codebase.

## The Two-Layer Validation Strategy

One of the most important patterns in DDD is having validation at **both** the Domain and Application layers. They serve different purposes:

### Application Layer Validation

**Purpose**: Ensure requests are well-formed before they reach the domain.

- Uses FluentValidation or similar on Commands/Queries
- Checks required fields, string lengths, format validation
- Returns validation errors (usually doesn't throw)
- Catches user input errors early

```csharp
public class CreateOrderCommandValidator : AbstractValidator<CreateOrderCommand>
{
    public CreateOrderCommandValidator()
    {
        RuleFor(x => x.CustomerId)
            .NotEmpty()
            .WithMessage("Customer ID is required");
            
        RuleFor(x => x.Items)
            .NotEmpty()
            .WithMessage("Order must have at least one item");
            
        RuleForEach(x => x.Items)
            .ChildRules(item =>
            {
                item.RuleFor(x => x.ProductId).NotEmpty();
                item.RuleFor(x => x.Quantity).GreaterThan(0);
            });
    }
}
```

### Domain Layer Validation

**Purpose**: Protect invariants - ensure entities can never exist in an invalid state.

- Lives in constructors, factory methods and business methods
- Enforces business rules
- Protects the integrity of your domain model
- This is where the real business logic validation happens

The pattern: **Application validates request structure, Domain protects its invariants.** You get defense in depth!

## Constructor vs Factory Method: A Pragmatic Approach

There's an ongoing debate about whether to throw exceptions in constructors or use factory methods. Here's a pragmatic hybrid approach:

### Value Objects: Throw in Constructor

Value objects are small, immutable and should always be valid. Throwing in the constructor makes sense:

```csharp
public class Email : ValueObject
{
    public string Value { get; }
    
    public Email(string value)
    {
        if (string.IsNullOrWhiteSpace(value))
            throw new ArgumentException("Email cannot be empty");
            
        if (!IsValidEmailFormat(value))
            throw new ArgumentException("Invalid email format");
            
        Value = value;
    }
    
    private static bool IsValidEmailFormat(string email)
    {
        // Email validation logic
        return Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
    }
    
    protected override IEnumerable<object> GetEqualityComponents()
    {
        yield return Value;
    }
}
```

**Why this works**: Value objects are usually created from already-validated input (after Application layer validation). If construction fails here, it's typically a programming error, not a user error.

### Entities: Factory Methods with Result Pattern

Entities have more complex creation logic and business rules. Factory methods with Result types give you better control:

```csharp
public class Customer : Entity
{
    public CustomerId Id { get; private set; }
    public string Name { get; private set; }
    public Email Email { get; private set; }
    public CustomerStatus Status { get; private set; }
    
    private Customer() { } // For EF Core
    
    public static Result<Customer> Create(string name, string emailAddress)
    {
        if (string.IsNullOrWhiteSpace(name))
            return Result.Failure<Customer>("Customer name is required");
            
        if (name.Length < 2)
            return Result.Failure<Customer>("Customer name must be at least 2 characters");
        
        Email email;
        try
        {
            email = new Email(emailAddress);
        }
        catch (ArgumentException ex)
        {
            return Result.Failure<Customer>(ex.Message);
        }
        
        var customer = new Customer
        {
            Id = CustomerId.New(),
            Name = name,
            Email = email,
            Status = CustomerStatus.Active
        };
        
        return Result.Success(customer);
    }
    
    public Result UpdateEmail(string newEmailAddress)
    {
        try
        {
            Email = new Email(newEmailAddress);
            return Result.Success();
        }
        catch (ArgumentException ex)
        {
            return Result.Failure(ex.Message);
        }
    }
}
```

**Why this works**: You get flexibility in error handling, cleaner testing and the ability to return meaningful validation errors to users.

### Avoiding Public Setters

In DDD, avoid public setters entirely. Instead, use methods with business meaning:

```csharp
// Bad
customer.Email = newEmail;

// Good
var result = customer.UpdateEmail(newEmailAddress);
if (result.IsFailure)
{
    // Handle error
}
```

This approach makes your code more expressive and ensures all changes go through proper validation.

## Quick Decision Guide

When adding a new type, ask yourself:

- **"Is this a business rule or concept?"** → Domain
- **"Is this coordinating a business workflow?"** → Application
- **"Does this talk to databases, APIs, or external services?"** → Infrastructure
- **"Is this handling HTTP concerns?"** → API/Presentation

## Implementing the Result Pattern

You don't need to build the Result type from scratch. Consider using a library:

- **FluentResults** - Popular, clean API
- **CSharpFunctionalExtensions** - Includes Result plus other functional programming goodies
- **ErrorOr** - Newer library with a nice API

Or create a simple implementation yourself:

```csharp
public class Result
{
    public bool IsSuccess { get; }
    public bool IsFailure => !IsSuccess;
    public string Error { get; }
    
    protected Result(bool isSuccess, string error)
    {
        IsSuccess = isSuccess;
        Error = error;
    }
    
    public static Result Success() => new Result(true, string.Empty);
    public static Result Failure(string error) => new Result(false, error);
    
    public static Result<T> Success<T>(T value) => new Result<T>(value, true, string.Empty);
    public static Result<T> Failure<T>(string error) => new Result<T>(default, false, error);
}

public class Result<T> : Result
{
    public T Value { get; }
    
    protected internal Result(T value, bool isSuccess, string error) 
        : base(isSuccess, error)
    {
        Value = value;
    }
}
```

## Conclusion

Clean Architecture with DDD gives you a powerful way to organize complex business logic, but it requires careful thought about boundaries. Remember:

1. **Domain** = Pure business logic, no external dependencies
2. **Application** = Orchestration and use case coordination
3. Validate at **both layers** for different purposes
4. Use **factory methods with Result** for entities, **throw in constructors** for value objects
5. Keep naming consistent - avoid "services" confusion

This approach gives you a maintainable, testable codebase that clearly separates concerns and makes your business logic shine.
