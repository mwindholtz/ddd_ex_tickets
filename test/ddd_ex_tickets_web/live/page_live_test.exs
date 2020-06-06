defmodule DddExTicketsWeb.PageLiveTest do
  use DddExTicketsWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to DddExTickets!"
    assert render(page_live) =~ "Welcome to DddExTickets!"
    assert render(page_live) =~ "Remaining: 30"
  end
end
