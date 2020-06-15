# Iteration 002

Adds a second independent Aggregate:  SalesTransation

## Stories
- [X] As a Ticket Shopper, I want to see price total.
- [..] As a Ticket Shopper, I want to see price total with 10% event tax.

### Coding moves taken
#### As a Ticket Shopper, I want to see price total.
- Replace :venue_changed with the two more specific domain events.
- Have Sale.Transaction listen to the :reserve_seat, and :release_seat domain events and track the price
- Sale.Transaction publishes :price_changed when needed
