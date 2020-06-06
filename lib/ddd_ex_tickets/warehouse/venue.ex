defmodule DddExTickets.Warehouse.Venue do
  use GenServer

  alias DddExTickets.Warehouse.Venue
  defstruct available: 30
  @impl true

  def start_link(state \\ %Venue{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(%Venue{} = venue) do
    {:ok, venue}
  end

  def reserve_seat do
    :ok
  end

  def available do
    venue = %DddExTickets.Warehouse.Venue{}
    venue.available
  end
end
