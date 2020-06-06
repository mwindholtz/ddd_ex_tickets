defmodule DddExTicketsWeb.PageLive do
  use DddExTicketsWeb, :live_view
  alias DddExTickets.Warehouse.Venue

  @impl true
  def mount(_params, _session, socket) do
    available = Venue.available()
    {:ok, assign(socket, tickets_requested: 0, results: %{}, remaining_count: available)}
  end

  @impl true
  def handle_event("request", %{"tickets_requested" => tickets_requested}, socket) do
    IO.inspect(tickets_requested, label: "---------------")
    {:noreply, assign(socket, tickets_requested: tickets_requested)}
  end
end
