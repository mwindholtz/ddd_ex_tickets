defmodule DddExTickets.Warehouse.VenueTest do
  use DddExTickets.DomainCase

  alias DddExTickets.Warehouse.Venue

  test "handle_call(:reserve_seat" do
    available = [1, 2, 3]
    state = %Venue{available: available}

    {:reply, :ok, state} = Venue.handle_call(:reserve_seat, self(), state)

    assert state.available == [2, 3]
    assert state.reserved == [1]
  end
end
