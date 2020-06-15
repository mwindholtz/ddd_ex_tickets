defmodule DddExTickets.DomainEvent do
  alias DddExTickets.DomainEvent

  defstruct name: nil

  defp new(name) do
    %DomainEvent{name: name}
  end

  def venue_changed do
    new(:venue_changed)
  end

  def seat_reserved do
    new(:seat_reserved)
  end

  def seat_released do
    new(:seat_released)
  end
end
