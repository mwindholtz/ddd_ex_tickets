defmodule DddExTickets.EventBusTest do
  use DddExTickets.DomainCase
  alias DddExTickets.EventBus
  alias DddExTickets.DomainEvent

  test "subscribe, publish, receive event" do
    domain_event = DomainEvent.seat_reserved(1)
    :ok = EventBus.subscribe()

    # When
    :ok = EventBus.publish(domain_event)
    assert_received ^domain_event
  end
end
