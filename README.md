# DddExTickets
Simple Ticket Office showing DDD contexts, and aggregates implemented in Elixir/Phoenix

#### Inspired by:
Mauro Servienti: [All Our Aggregates Are Wrong ](https://www.youtube.com/watch?v=KkzvQSuYd5I),  Explore DDD 2018 - Denver, Sept. 11-14

## Stories
##### For Minimal Viable Product (MVP)
- There will be only one show available in the system.
- The number of tickets is set at 30
- All tickets will be priced at $100/seat

##### Iteration 001
- Create an Aggregate for **Venue** to manage the seats of one show at one venue

##### Iteration 002
- Create another Aggregate for **SaleTransaction** to calculate the cost of the sale

##### Iteration 003
- Allow a transaction to be rolled back without central synconization


#### Vision
- Aggregates using Eventual Consistency
- Sales sets the price, Venue assigns the tickets.
- Sales listens to changes in Venue and updates price
- ** Needs to have a rollback senario, to show event sourceing

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Next
Next we look at a code example of putting some of these ideas together.
[DDD is Domain Driven Design.  Elixir example](https://github.com/mwindholtz/ddd_ex_tickets/blob/master/docs/introduction.md)