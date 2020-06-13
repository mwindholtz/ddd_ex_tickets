# Iteration 001

To keep this very simple, the MVP will have hardcoded seats and costs (for now)

##### For Minimal Viable Product (MVP)
- There will be only one show available at one Venue in the system.
- The number of seats is set at 30
- All tickets will be priced at $100/seat

## Stories
#### Backlog
- [x] As a Ticket Shopper, I want to see the number of tickets available.
- [x] As a Ticket Shopper, I want to increment / decrement the number of tickets in my cart.
- [x] As a Ticket Shopper, I want to see the number of tickets available after reserving one.
- [x] As a Ticket Shopper, I want to see my ticket numbers.

#### The Approach
1. Create a test for the text "Remaining: 30".
1. Hardcode that value in the HTML to get the test working
1. Refactor the value into a better place.   First the LiveView, and then into an Aggregate.
1. Add the ability to change the state by making the Aggregate into a GenServer
1. Add the ability to update the UI by adding DomainEvent for :venue_changed

The app now has one Aggregate (Venue) that can be updated and lets others know when it has changed.

### Coding moves taken
#### As a Ticket Shopper, I want to see the number of tickets available.
- created a default phoenix live_view application [code](https://github.com/mwindholtz/ddd_ex_tickets/tree/1a1794ac3b1b66d266ac1eed42cf798405ef194e).
- added a test to ```elixir  assert render(page_live) =~ "Remaining: 30"  ```
- Hardcoded "Remaining: 30" into the HTML
- Refactored the "Remaining: 30" to move it into the LiveView Page [code](https://github.com/mwindholtz/ddd_ex_tickets/commit/17619327bd04a1910710ab9bbde43ccf70358919)
- Refactored the "Remaining: 30" to move it into Venue [code](https://github.com/mwindholtz/ddd_ex_tickets/commit/854b058bce211206ba2f0810575e058b456a0995)

#### As a Ticket Shopper, I want to increment / decrement the number of tickets in my cart.
- Created Venue as a GenServer so that it can change state [code](https://github.com/mwindholtz/ddd_ex_tickets/commit/563b327e9c386b8226820406eb5c69d709a6f900)

#### As a Ticket Shopper, I want to see the number of tickets available after reserving one.
- Added an EventBus and DomainEvent :venue_changed [code](https://github.com/mwindholtz/ddd_ex_tickets/tree/d34df01daa8b7ccac1291c2660fcd0400f998998)

#### As a Ticket Shopper, I want to see my ticket numbers.
- Venue Provides seat numbers for reserved seats [code](https://github.com/mwindholtz/ddd_ex_tickets/tree/ce825204c0a7f1c2903e8f3b567d113dcca8f385)
