defmodule DddExTickets.DomainEventTest do
  use DddExTickets.DomainCase
  alias DddExTickets.DomainEvent

  test "venue_changed" do
    # When
    result = DomainEvent.venue_changed()
    assert %DomainEvent{} = result
    assert result.name == :venue_changed
  end
end
