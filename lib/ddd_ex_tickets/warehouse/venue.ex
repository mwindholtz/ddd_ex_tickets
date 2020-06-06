defmodule DddExTickets.Warehouse.Venue do
  use GenServer

  alias DddExTickets.Warehouse.Venue
  defstruct available: 30

  def start_link(state \\ %Venue{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(%Venue{} = venue) do
    {:ok, venue}
  end

  # Client Interface -----------------------------
  def reserve_seat do
    :ok
  end

  def available do
    GenServer.call(__MODULE__, :available)
  end

  # Server Interface ---------------------

  def handle_call(:available, _from, %Venue{} = state) do
    venue = %DddExTickets.Warehouse.Venue{}
    reply_value = venue.available
    {:reply, reply_value, state}
  end
end
