defmodule DddExTickets.Warehouse.Venue do
  use GenServer

  alias DddExTickets.Warehouse.Venue
  alias DddExTickets.EventBus
  alias DddExTickets.DomainEvent

  @default_seats 1..30 |> Enum.to_list()

  defstruct available: @default_seats, reserved: []

  def start_link(state \\ %Venue{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(%Venue{} = venue) do
    {:ok, venue}
  end

  # Client Interface -----------------------------
  def reserve_seat do
    GenServer.call(__MODULE__, :reserve_seat)
  end

  def available do
    GenServer.call(__MODULE__, :available)
  end

  def reserved_seats do
    GenServer.call(__MODULE__, :reserved_seats)
  end

  # Server Interface ---------------------

  @impl true
  def handle_call(:available, _from, %Venue{available: available} = state) do
    reply_value = available |> Enum.count()
    {:reply, reply_value, state}
  end

  @impl true
  def handle_call(:reserved_seats, _from, %Venue{reserved: reserved} = state) do
    {:reply, reserved, state}
  end

  @impl true
  def handle_call(
        :reserve_seat,
        _from,
        %Venue{available: available, reserved: reserved} = state
      ) do
    %DomainEvent{name: :venue_changed}
    |> EventBus.publish()

    [reserved_seat | available] = available
    reserved = [reserved_seat | reserved]
    state = %{state | available: available, reserved: reserved}
    {:reply, :ok, state}
  end

  def handle_call(
        :release_seat,
        _from,
        %Venue{available: available, reserved: reserved} = state
      ) do
    %DomainEvent{name: :venue_changed}
    |> EventBus.publish()

    [released_seat | reserved] = reserved
    available = [released_seat | available]
    state = %{state | available: available, reserved: reserved}
    {:reply, :ok, state}
  end
end
