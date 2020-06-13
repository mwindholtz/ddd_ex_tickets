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
- Code delivery becoming slower
- Unacceptable code defects
- Large, awkward setup code for unit tests
- Long running unit tests.  Greater than > 5 minutes (Elixir is fast and concurrent, so tests should be fast)

A weak point of some Agile software processes is that they encourage a style of feature based development that layers features on top of features without looking into the deeper core of the problem space.  I call this **Featuritus**.   Getting the most points done per interation without continually developing the core leads to confusion.

It is simpler to understand business constraints and rules when they are in the core domain model than to handle them on the edges in feature code.
It is faster in the *short term* to *build* one feature at a time, and to build the rules and constraints in one feature at a time.  But this leaves duplicate concepts and hard to locate logic around the edges of the application.
