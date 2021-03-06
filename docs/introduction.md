# DDD is Domain Driven Design.  Elixir examples

## Introduction

I had a conversation with the good folks at [Elixir Wizards](https://podcasts.google.com/?feed=aHR0cHM6Ly9wb2RjYXN0LnNtYXJ0bG9naWMuaW8vcnNz&ved=2ahUKEwjguPeuhofqAhWvRTABHXLtC8AQ4aUDegQIARAC&hl=en) about [Domain Driven Design](https://martinfowler.com/bliki/DomainDrivenDesign.html).
It was a lot of fun, but I get the feeling that wasn't as clear as it could have been.

Explaining All of DDD in a free flowing discussion in under an hour is probably not possible.
Even a post like this will not be able to explain the full depth of the goals and value of DDD.

#### Goal
This post is an introductory overview of DDD.
And I'll follow-up with a code example of implementing a super simplified app in Elixir with DDD-Aggregates.

Lets get started ...

### What is DDD?
Domain Driven Design is a kit of thinking tools for building complex systems and applications.  It includes:
- Communication Techniques: sharing and understanding what is important.
- Strategic Patterns: big parts and how they relate to each other.
- Tactical Patterns: code level separating the core from non-core.
- Vision and Values.

DDD helps organize the concepts of your problem.  One part of that is implementing those concepts in code.  But coding is not the biggest concern.   **Communicating** is the biggest concern.  In DDD we code in a way that makes the communicating easier.

#### Architecture and Design
- **Architecture** supports the full range technical and business needs.  One goal in architecture is to provide a safe space to express the core design
 - **Design** is the place in the architecture where the core behavior of the application is represented.  The core behavior is the reason the application is being created.  This is where the system provides its value.

### How do I know I need it?
DDD is intended for complex applications and systems. Using full DDD on simple applications can make the app harder to understand and maintain.

But sometimes simple applications grow-up to become complicted applications.  The point at which DDD becomes helpful is often recognized later than it should be when the application has already become complicated.

However, *Learning* the Tactical patterns (i.e. coding patterns) of DDD is easier when building a small application.  A simple application can be good for learning DDD.

I recommend building a small application with DDD patterns, in order to learn.   But don't send that to production. [DDDExTickets](https://github.com/mwindholtz/ddd_ex_tickets) example is an attempt to show parts of the DDD tactical patterns in one possible implementation.

#### Symptoms of poor a Domain Model
Lacking a useful Domain Model has the following symptoms.
- It's hard for the Domain Experts to understand tech team's proposed solutions
- Domain Experts awkwardly try to use tech terms to express themselves
- Technical team uses techie words when talking to Domain Experts. For example: table, fields, schemas, locks
- Slowing Code delivery
- Miscommunicated requirements causing code defects
- Large, awkward setup code for unit tests
- Long running unit tests.  Greater than > 5 minutes (Elixir is fast and concurrent, so tests should be fast)

A weak point of some *Agile* software processes is that they encourage a style of feature based development that layers features on top of features without looking into the deeper core of the problem space.  This is called **Featuritus**.   Getting the most points done per iteration without continually developing the core leads to confusion in the design.

It is simpler to understand business constraints and rules when they are in the core domain model than it is to handle them on the edges in feature code.
It is faster in the *short term* to *build* one feature at a time, and to build the rules and constraints in one feature at a time.  But this leaves duplicate concepts and hard to locate logic around the edges of the application.

## The Main Parts of DDD

### Communication Techniques: sharing and understanding what is imporantant.
DDD has various techniques to help Domain Experts and Technical team communicate and collaborate in building the Model.  This include:  **Event Storming**, and **WhirlPooling**, among others.
Ongoing Communication between domain experts and the technical team is the key to DDD.
DDD is a continuous refinement of the model of the system shared between tech and domain experts.
When a new concept is found, it is defined and named, and becomes part of the code.
The code must change to reflect the unfolding understanding of the concepts in the problem.
Modeling is iterative and ongoing as new understanding is developed by the whole team.

### Stratigic Patterns
These patterns help organize large scale parts of a complicated domain.
We want to highlight when we are dealing with the **problem space** and when we are dealing with the **solution space**

#### Core Domain, Sub-Domain
These are in the **problem space** in the real world.
A **Domain** is a sphere of the knowledge.
The **Core Domain** is the most important part of the problem we are trying to solve.
 Examples could be areas like:
- TicketSales Domain
- SeatAllocation SubDomain
- Billing SubDomain
A **Sub Domain** is an area of knowledge that is not the main value in the application

#### Bounded Context
The **Bounded Context** is in the **solution space**.  We name modeling concepts within a particular *Bounded Context*.  We often see these align with the departments in a company. Example Bounded Contexts:
- Sales
- Warehousing
- Billing
Typically we want one team and one repo for each bounded context.  Within the BoundedContext the Model the Ubiquitous Language evolves based on the conversations between the technical team and the domain experts.

#### Context Map
A Context Map shows the relationships between Bounded Contexts.  This helps us understand the flow of Model changes among the connected Bounded Contexts.  Sometimes a change in one Bounded Context effects another Bounded Context.   Sometime it does not.  When the relationships are mapped you can see the potential effect of model changes on the entier system.

#### Ubiquitous Language
**Ubiquitous Language** is a language defined by both the Domain Experts and Technical team.  We use words that the domain Expert uses in the Problem Space and define those worked to mean something percise within the area of the BoundedContext.
In an insurance application for example, the concept *Policy* may mean different things to different departments.  Each department should define *Policy* within its own BoundedContext.
Words defined in the Ubiquitous Language should be directly represented in the structs and functions of our Elixir code.  That is why we can it *"Ubiquitous"*.   The names of these things are in the Domain and in the code.   And yes, this takes some skill development to do well.  The tactical patterns are helpful for this.

### Tactical Patterns
The Tactical Patterns are where the Model meets the Code.  Tactical patterns are how we can make the Ubiquitous Language show up in our code modules and functions.  It's important to understand that no one Model is "Right".  A Model is made to be useful.   And we should explore multiple Models before jumping into the coding.  Also the Model *will change*  as you learn more about the problem.  The tactical patterns should help make those changes easier.

#### Value Object
ValueObject is immutable data, the value of which is only set during construction. An example is a DateTime.  This is more helpful in an Object Oriented language, since in Elixir all data structures are immutable.

#### Entity
An Entity is long lived data that has an identity, and can change its properties over time.
An Entity in Elixir would be data that lives in a Database, and can be changed in the DB over time.
It would be a Struct with an *Ecto Schema*

#### Aggregate
An Aggregate is one Entity, or a tree of Entities with one Entity at the root.  The root is called the AggregateRoot.   The AggregateRoot is the only interface into the Aggregate and maintains transactions so that the Aggregate internals are always consistent and valid.   The ids of the contained Entities are hidden inside the Aggregate and not published through the Aggregate root's interface.

Much of DDD modeling deals with finding, and naming Aggregates and decoupling Aggregates from each other.
This is key to robustness and scalability.
Aggregates can be implemented with Elixir GenServers.
In the **DddExTickets** example
- [Venue](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_001/lib/ddd_ex_tickets/warehouse/venue.ex) is an Aggregate that manages the allocation of Seat ValueObjects.
- [Sales.Transaction](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_002/lib/ddd_ex_tickets/sales/transaction.ex) is an Aggregate that calculates the sales price without knowing about the Venue.

#### DomainEvent
A [DomainEvent](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_001/lib/ddd_ex_tickets/domain_event.ex) is an event that the Domain Expert cares about from the real-world.  It is expressed in past-tense to show that it already happened. **Seat Reserverd**,  **TicketPurchased**, **Seat Available**


### Vision and Values: Help in times of stress.
1. Communication between DomainExperts and Developers
1. Iterative Development
1. Ubiquitous Language


## Next
Next we look at a code example of putting some of these ideas together.
But it's important to keep in mind that the main focus of DDD is communication, and modeling in a ubiqutous language.   The focus of the code is to reflect the model and ubiqutous language.
[iteration_001](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_001/docs/iteration_001.md)
