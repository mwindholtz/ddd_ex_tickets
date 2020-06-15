defmodule DddExTickets.DomainEventTest do
  use DddExTickets.DomainCase
  alias DddExTickets.DomainEvent

  test "venue_changed" do
    # When
    result = DomainEvent.venue_changed()
    assert %DomainEvent{} = result
    assert result.name == :venue_changed
  end

  test "seat_reserved" do
    # When
    result = DomainEvent.seat_reserved()
    assert %DomainEvent{} = result
    assert result.name == :seat_reserved
  end

  test "seat_released" do
    # When
    result = DomainEvent.seat_released()
    assert %DomainEvent{} = result
    assert result.name == :seat_released
  end
end
