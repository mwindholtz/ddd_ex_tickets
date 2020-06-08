defmodule DddExTicketsWeb.PageLiveTest do
  use DddExTicketsWeb.ConnCase

  import Phoenix.LiveViewTest

  @venue_module DddExTickets.Warehouse.Venue
  setup do
    # Since Venue is a global resource
    # we need to stop it between each test
    # The supervisor will restart it, up to a point
    GenServer.stop(@venue_module)
    wait_for_venue_to_restart()
    :ok
  end

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")

    assert disconnected_html =~ "Welcome to DddExTickets!"
    assert render(page_live) =~ "Welcome to DddExTickets!"
    assert render(page_live) =~ "Remaining: 30"
  end

  test "reserve a ticket and see 29 remaining", %{conn: conn} do
    conn = assign(conn, :venue_pid, DddExTickets.Warehouse.Venue)
    DddExTickets.Warehouse.Venue.reserve_seat()
    {:ok, page_live, _disconnected_html} = live(conn, "/")
    assert render(page_live) =~ "Remaining: 29"
  end

  defp wait_for_venue_to_restart do
    case Process.whereis(@venue_module) do
      nil ->
        Process.sleep(10)
        wait_for_venue_to_restart()

      pid ->
        pid
    end
  end
end
