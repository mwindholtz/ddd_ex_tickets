# DddExTickets
Simple Ticket Office showing DDD contexts, and aggregates implemented in Elixir/Phoenix

#### Inspired by:
Mauro Servienti: [All Our Aggregates Are Wrong ](https://www.youtube.com/watch?v=KkzvQSuYd5I),  Explore DDD 2018 - Denver, Sept. 11-14

## Stories
##### For Minimal Viable Product (MVP)
- There will be only one show available in the system.
- The number of tickets is set at 30
- All tickets will be priced at $100/seat

#### Backlog

- [X] s  As a Ticket Shopper, I want to see the number of tickets available.
- [X] As a Ticket Shopper, I want to increment / decrement the number of tickets in my cart.
- [X] As a Ticket Shopper, I want to see the number of tickets available after reserving one.
- [X] As a Ticket Shopper, I want to see my ticket numbers.
- [.] As a Ticket Shopper, I want to see price total with 10% event tax.


#### Vision
- Aggregates using Eventual Consistency
- Sales sets the price, Venue assigns the tickets.
- Sales listens to changes in Venue and updates price
- ** Needs to have a rollback senario, to show event sourceing

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
