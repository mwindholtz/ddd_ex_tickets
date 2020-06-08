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

  test "handle_call(:release_seat" do
    reserved = [1]
    available = [2, 3]
    state = %Venue{available: available, reserved: reserved}

    {:reply, :ok, state} = Venue.handle_call(:release_seat, self(), state)

    assert state.available == [1, 2, 3]
    assert state.reserved == []
  end

  test "handle_call(:reserved_seats" do
    reserved = [1, 2, 3]
    state = %Venue{reserved: reserved}

    {:reply, ^reserved, state} = Venue.handle_call(:reserved_seats, self(), state)

    assert state.reserved == reserved
  end
end
