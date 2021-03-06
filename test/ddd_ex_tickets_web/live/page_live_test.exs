defmodule DddExTicketsWeb.PageLiveTest do
  use DddExTicketsWeb.ConnCase

  import Phoenix.LiveViewTest
  alias DddExTicketsWeb.PageLive
  alias DddExTickets.DomainEvent
  alias DddExTickets.Warehouse.Venue

  describe "using global servers" do
    setup do
      # Since Venue is a global resource
      # we need to stop/start it after each test
      # The supervisor will restart it, up to a point
      on_exit(fn ->
        GenServer.stop(Venue)
        wait_for_venue_to_restart()
        :ok
      end)
    end

    test "disconnected and connected render", %{conn: conn} do
      {:ok, page_live, disconnected_html} = live(conn, "/")

      assert disconnected_html =~ "Welcome to DddExTickets!"
      assert render(page_live) =~ "Welcome to DddExTickets!"
      assert render(page_live) =~ "Remaining: 30"
    end

    test "reserve a ticket and see 29 remaining", %{conn: conn} do
      DddExTickets.Warehouse.Venue.reserve_seat()
      {:ok, page_live, _disconnected_html} = live(conn, "/")
      assert render(page_live) =~ "Remaining: 29"
    end
  end

  test "handle_info(%DomainEvent{name: :seat_released}" do
    socket = %Phoenix.LiveView.Socket{}
    domain_event = DomainEvent.seat_released(1)

    assert {:noreply, socket} = PageLive.handle_info(domain_event, socket)

    assert socket.assigns == %{remaining_count: 30, results: []}
  end

  test "handle_info(%DomainEvent{name: :seat_reserved}" do
    socket = %Phoenix.LiveView.Socket{}
    domain_event = DomainEvent.seat_reserved(1)

    assert {:noreply, socket} = PageLive.handle_info(domain_event, socket)
    assert socket.assigns == %{remaining_count: 30, results: []}
  end

  test "handle_info(%DomainEvent{name: :price_changed}" do
    socket = %Phoenix.LiveView.Socket{}
    domain_event = DomainEvent.price_changed(Money.new(10_000))

    assert {:noreply, socket} = PageLive.handle_info(domain_event, socket)
    assert socket.assigns == %{price_in_cents: "$100.00"}
  end

  test "ignore: handle_info(%DomainEvent{name: :other}" do
    socket = %Phoenix.LiveView.Socket{}
    domain_event = %DomainEvent{name: :ignore}

    assert {:noreply, socket} = PageLive.handle_info(domain_event, socket)
  end

  defp wait_for_venue_to_restart do
    case Process.whereis(Venue) do
      nil ->
        Process.sleep(10)
        wait_for_venue_to_restart()

      pid ->
        pid
    end
  end
end
