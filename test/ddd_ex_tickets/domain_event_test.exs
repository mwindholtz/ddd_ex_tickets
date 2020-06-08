defmodule DddExTickets.DomainEventTest do
  use DddExTickets.DomainCase
  alias DddExTickets.DomainEvent

  test "new" do
    # When
    result = DomainEvent.new("ping")
    assert %DomainEvent{} = result
    assert result.name == "ping"
  end
end
