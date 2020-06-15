defmodule DddExTickets.DomainEventTest do
  use DddExTickets.DomainCase
  alias DddExTickets.DomainEvent

  test "seat_reserved" do
    # When
    result = DomainEvent.seat_reserved(1)
    assert %DomainEvent{} = result
    assert result.name == :seat_reserved
    assert result.content == 1
  end

  test "seat_released" do
    # When
    result = DomainEvent.seat_released(3)
    assert %DomainEvent{} = result
    assert result.name == :seat_released
    assert result.content == 3
  end

  test "price_changed" do
    # When
    result = DomainEvent.price_changed(1_000)
    assert %DomainEvent{} = result
    assert result.name == :price_changed
    assert result.content == 1_000
  end
end
