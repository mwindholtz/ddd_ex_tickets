defmodule DddExTickets.Sales.TransactionTest do
  use DddExTickets.DomainCase
  alias DddExTickets.Sales.Transaction
  alias DddExTickets.DomainEvent
  alias DddExTickets.EventBus

  describe "Subscribed to EventBus" do
    setup do
      :ok = EventBus.subscribe()
      :ok
    end

    test "handle_info(%DomainEvent{name: :seat_reserved}" do
      state = %Transaction{price_in_cents: 0}
      domain_event = DomainEvent.seat_reserved(1)

      {:noreply, state} = Transaction.handle_info(domain_event, state)

      assert state.price_in_cents == 10_000
      assert_receive %DomainEvent{name: :price_changed, content: 10_000}
    end

    test "handle_info(%DomainEvent{name: :seat_released}" do
      state = %Transaction{price_in_cents: 40_000}
      domain_event = DomainEvent.seat_released(1)

      {:noreply, state} = Transaction.handle_info(domain_event, state)

      assert state.price_in_cents == 30_000
      assert_receive %DomainEvent{name: :price_changed, content: 30_000}
    end

    test "handle_info(%DomainEvent{name: :price_changed} ignored" do
      state = %Transaction{}
      domain_event = %DomainEvent{name: :ignore}
      assert {:noreply, ^state} = Transaction.handle_info(domain_event, state)
    end
  end
end
