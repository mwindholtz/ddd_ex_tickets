defmodule DddExTickets.Warehouse.Venue do
  defstruct available: 30

  def reserve_seat do
    :ok
  end

  def available do
    venue = %DddExTickets.Warehouse.Venue{}
    venue.available
  end
end
