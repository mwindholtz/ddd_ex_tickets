# Iteration 002

Adds a second independent Aggregate:  SalesTransation

## Stories
- [X] As a Ticket Shopper, I want to see price total.
- [..] As a Ticket Shopper, I want to see price total with 10% event tax.

### Coding moves taken
#### As a Ticket Shopper, I want to see price total.
This will eventually require a Sales.Transaction that listens for events :seat_registered, and :seat_released.   Currently the code only publishes :venue_changed.
- The first step is to replace :venue_changed with the two more specific domain events.
