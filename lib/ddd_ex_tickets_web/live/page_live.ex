defmodule DddExTicketsWeb.PageLive do
  use DddExTicketsWeb, :live_view
  alias DddExTickets.Warehouse.Venue
  alias DddExTickets.EventBus
  alias DddExTickets.DomainEvent

  # tickets_requested: 0,
  # results: %{},
  # remaining_count: []

  @impl true
  def mount(_params, _session, socket) do
    :ok = EventBus.subscribe()
    available = Venue.available()
    {:ok, assign(socket, tickets_requested: 0, results: %{}, remaining_count: available)}
  end

  @impl true
  def handle_event("inc", _params, socket) do
    Venue.reserve_seat()
    {:noreply, socket}
  end

  def handle_event("dec", _params, socket) do
    Venue.reserve_seat()
    {:noreply, socket}
  end

  @impl true
  def handle_info(%DomainEvent{name: :venue_changed}, state) do
    IO.inspect(state, label: "%DomainEvent{name: :venue_changed}")
    available = Venue.available()

    new_state =
      state
      |> assign(remaining_count: available)

    {:noreply, new_state}
  end
end
