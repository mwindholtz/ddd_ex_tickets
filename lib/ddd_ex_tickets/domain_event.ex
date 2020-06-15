defmodule DddExTickets.DomainEvent do
  alias DddExTickets.DomainEvent

  defstruct name: nil, content: nil

  defp new(name, content) do
    %DomainEvent{name: name, content: content}
  end

  def seat_reserved(seat_number) do
    new(:seat_reserved, seat_number)
  end

  def seat_released(seat_number) do
    new(:seat_released, seat_number)
  end

  def price_changed(new_price_in_cents) do
    new(:price_changed, new_price_in_cents)
  end
end
