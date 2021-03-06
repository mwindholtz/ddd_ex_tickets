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
    socket = assign(socket, :price_in_cents, Money.to_string(Money.new(0)))

    {:ok, refresh(socket)}
  end

  @impl true
  def handle_event("inc", _params, socket) do
    Venue.reserve_seat()
    {:noreply, socket}
  end

  @impl true
  def handle_event("dec", _params, socket) do
    Venue.release_seat()
    {:noreply, socket}
  end

  # DomainEvents -----------------------------------------------------
  @impl true
  def handle_info(%DomainEvent{name: :seat_reserved}, socket) do
    {:noreply, refresh(socket)}
  end

  @impl true
  def handle_info(%DomainEvent{name: :seat_released}, socket) do
    {:noreply, refresh(socket)}
  end

  @impl true
  def handle_info(%DomainEvent{name: :price_changed, content: new_price_in_cents}, socket) do
    socket =
      socket
      |> assign(:price_in_cents, Money.to_string(new_price_in_cents))

    {:noreply, socket}
  end

  @impl true
  def handle_info(%DomainEvent{name: _ignore_other}, socket) do
    {:noreply, socket}
  end

  # Private Implementation -------------------------------------------

  defp refresh(socket) do
    socket
    |> assign(remaining_count: Venue.available())
    |> assign(results: Venue.reserved_seats())
  end
end
