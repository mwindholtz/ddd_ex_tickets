# DDD is Domain Driven Design.  Elixir examples

## Introduction

I recently had a conversation with the folks at Elixir Wizards.
It was a lot of fun, but I get the feeling that wasn't as clear as it could have been.

Adaquately explaining DDD in a free flowing discussion in under an hour is probably not possible.
Even a post like this will not be able to explain the full depth of the goals and value of DDD.

### What is DDD?
Domain Driven Design is a kit of thinking tools for building complex systems and applications.  It includes:
- Stratigic Patterns: big parts and how they relate to each other
- Tactical Patterns: code level separating the core from the support.
- Communication Techniques: sharing and understanding what is imporantant
- Vision and Values: Help in times of stress.

#### Concerns of Architecture and Design
- *Architecture* is about support for the full range technical and business needs.  One goal in architecture is to provide a safe space to express the core design
 - *Design* is the part and place in the architecture where the core behavior of the application is represented.


### How do I know I need it?

DDD is intended for complex applications and systems.   Using full DDD on simple applications is usually not helpful.

But sometimes simple applications grow-up to become complicted applications.  And the point where DDD becomes recognized as heplful is often later than it should be.

#### Symptoms
- code delivery becoming slower
- unexceptable code defects
- Large, awkward setup code for unit tests
- long running unit tests.  Greater than > 5 minutes

A weak point of some Agile software processes is that they encourage a style of feature based development that layers features on top of features without looking into the deeper core of the problem space.

It is simpler to understand business constraints and rules when they are in the core domain model than to handle them on the edges in feature code.
It is faster in the _short term_ to /build/ one at a time features and code  the rules and constrains in one feature at a time.  But this leaves duplicate concepts and hard to locate logic around the edges of the application.
