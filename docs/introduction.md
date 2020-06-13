# DDD is Domain Driven Design.  Elixir examples

## Introduction

I recently had a conversation with the good folks at Elixir Wizards.
It was a lot of fun, but I get the feeling that wasn't as clear as it could have been.

Adaquately explaining DDD in a free flowing discussion in under an hour is probably not possible.
Even a post like this will not be able to explain the full depth of the goals and value of DDD.

#### Goal
This post will be an introductory overview of DDD.
And I'll follow-up with a multipost example of implementing a super simplified app in Elixir with DDD-Aggragates.

Lets get started ...

### What is DDD?
Domain Driven Design is a kit of thinking tools for building complex systems and applications.  It includes:
- Stratigic Patterns: big parts and how they relate to each other.
- Tactical Patterns: code level separating the core from the support.
- Communication Techniques: sharing and understanding what is imporantant.
- Vision and Values: Help in times of stress.

#### Concerns of Architecture and Design
- *Architecture* is about support for the full range technical and business needs.  One goal in architecture is to provide a safe space to express the core design
 - *Design* is the place in the architecture where the core behavior of the application is represented.  The core behavior is the reason the application is being created.


### How do I know I need it?

DDD is intended for complex applications and systems.   Using full DDD on simple applications is usually not helpful and can make the app harder to understand and maintain.

But sometimes simple applications grow-up to become complicted applications.  The point where DDD becomes recognized as heplful is often later than it should be.

Also, *Learning* the Tactical patterns of DDD is easier when building a small application.  And while that is good for learning it may not be best for maintaining the simple application.

I recommend building a small application with DDD patterns, in order to learn.   But don't send that to production.  That what the [DDDExTickets](https://github.com/mwindholtz/ddd_ex_tickets) example is for.

Lacking a useful Domain Model has some of the following symptoms.

#### Symptoms of poor a Domain Model
- Slowing Code delivery
- Unacceptable code defects
- Large, awkward setup code for unit tests
- Long running unit tests.  Greater than > 5 minutes (Elixir is fast and concurrent, so tests should be fast)

A weak point of some Agile software processes is that they encourage a style of feature based development that layers features on top of features without looking into the deeper core of the problem space.  This is called **Featuritus**.   Getting the most points done per interation without continually developing the core leads to confusion.

It is simpler to understand business constraints and rules when they are in the core domain model than to handle them on the edges in feature code.
It is faster in the *short term* to *build* one feature at a time, and to build the rules and constraints in one feature at a time.  But this leaves duplicate concepts and hard to locate logic around the edges of the application.

## Parts of DDD
### Stratigic Patterns
These patterns help organize large scale parts of a complecated domain.
We want to highlight when we are dealing with the **Problem Space** and when we are dealing with the **Solution Space**

#### Core Domain, Sub-Domain
The an area in the **Problem Space**.  A sphere of the knowledge ....
The *Core Domain* is the most important part of the problem we are trying to solve.
 Examples could be areas like: TicketSales Domain, SeatAllocation SubDomain, and Billing SubDomain

#### Bounded Context
The Bounded Context is in the **Solution Space**.  We name modeling concepts within a particular *Bounded Context*.  We often see these align with the departments in a company. Example Bounded Contexts: Sales, Warehousing, and Billing

#### Context Map
A Context Map will show the relationships between Bounded Contexts.  This helps us undersand flow of Model changes among the connected Bounded Conexts.

#### Ubiqutious Language
**Ubiqutious Language** is a language that we define.  We use words that the domain Expert uses in the Problem Space and define those worked to mean something percise within the area of the BoundedContext.
In an insurance application for example, the concept *Policy* may mean different things to different departments.  Each department should define *Policy* within it's own BoundedContext.
Words defined in the Ubiqutious Language should be directly represented in the structs and functions of our Elixir code.  That is why we cann it *"Ubiqutious"*.   The names of these things are in the Domain and in the code.   And yes, this takes some skill development to do well.  The tactical patterns are helpful for this.

### Tactical Patterns
The Tactical Patterns is where the Model meets the Code.  Tactical patterns are how we can make the Ubiqutious Language show up in our code modeuls and functions.

#### Value Object
ValueObject is immutable data the value of which is only set during construction, like a DateTime.  This is more helpful in an Object Oriented language, since in Elixir all data structures are immutable.

#### Entity
An Entity is longer lived data that has an identity, and can change it's properties over time.
An Entity in Elixir would be data that lives in a Database, and can be changed in the DB as needed.
It would be a Struct with an *Ecto Schema*

#### Aggregate
An Aggregate is one Entity, or a tree of Entities with one at the root.  The root is called the AggregateRoot.   The AggregateRoot is the ony interface into the Aggregate and maintains transactions so that the Aggregate internals are always consistent and valid.

Much of DDD modeling deals with finding, and naming Aggregates and decoupling Aggregates from each other.
This is key to robustness and scalability.
Aggregates can be implemented with Elixir GenServers.
In the **DddExTickets** example [Venue](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_001/lib/ddd_ex_tickets/warehouse/venue.ex) is an Aggregate that mananges the allocation of Seat ValueObjects.

#### DomainEvent
A [DomainEvent](https://github.com/mwindholtz/ddd_ex_tickets/blob/iteration_001/lib/ddd_ex_tickets/domain_event.ex) is and event that the Domain Expert cares about from the real-world.  It is expressed in past-tense to show that it already happened. **Seat Reserverd**,  **TicketPurchased**, **Seat Available**

### Communication Techniques: sharing and understanding what is imporantant.
DDD has various techniques to help Domain Experts and Technical team communicate and collaborate in building the Model.  This incelude:  **Event Storming**, and **WhirlPooling**, among others.

### Vision and Values: Help in times of stress.
1. Communication between DomainExperts and Developers
1. Iterative Development
1. Ubiqutious Language


## Next
Next lets look at a code example of putting some of these ideas together.