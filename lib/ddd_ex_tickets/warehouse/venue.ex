defmodule DddExTickets.Warehouse.Venue do
  defstruct available: 30

  def available do
    venue = %DddExTickets.Warehouse.Venue{}
    venue.available
  end
end
