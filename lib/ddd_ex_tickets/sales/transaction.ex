defmodule DddExTickets.Sales.Transaction do
  use GenServer

  alias DddExTickets.Sales.Transaction
  alias DddExTickets.EventBus
  alias DddExTickets.DomainEvent

  defstruct price_in_cents: 0

  @standard_ticket_price_in_cents 10_000

  # Client Interface ---------------------
  def start_link(state \\ %Transaction{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(%Transaction{} = transaction) do
    :ok = EventBus.subscribe()
    {:ok, transaction}
  end

  # Server Interface ---------------------

  # DomainEvents -----------------------------------------------------

  @impl true
  def handle_info(%DomainEvent{name: :seat_reserved}, state) do
    state = add_seat(state)
    publish_price_changed(state.price_in_cents)
    {:noreply, state}
  end

  @impl true
  def handle_info(%DomainEvent{name: :seat_released}, state) do
    state = remove_seat(state)
    publish_price_changed(state.price_in_cents)
    {:noreply, state}
  end

  @impl true
  def handle_info(%DomainEvent{name: _ignored}, state) do
    {:noreply, state}
  end

  # Implementation ---------------------

  def add_seat(%Transaction{price_in_cents: price_in_cents} = state) do
    %{state | price_in_cents: price_in_cents + @standard_ticket_price_in_cents}
  end

  def remove_seat(%Transaction{price_in_cents: price_in_cents} = state) do
    %{state | price_in_cents: price_in_cents - @standard_ticket_price_in_cents}
  end

  defp publish_price_changed(price_in_cents) do
    DomainEvent.price_changed(price_in_cents)
    |> EventBus.publish()
  end
end
