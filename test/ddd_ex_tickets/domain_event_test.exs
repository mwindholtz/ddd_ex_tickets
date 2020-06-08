defmodule DddExTicket.DomainEventTest do
  use DddExTickets.DomainCase
  alias DddExTicket.DomainEvent

  test "new" do
    # When
    result = DomainEvent.new("ping")
    assert %DomainEvent{} = result
    assert result.name == "ping"
  end
end
