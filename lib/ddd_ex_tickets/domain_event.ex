defmodule DddExTickets.DomainEvent do
  alias DddExTickets.DomainEvent

  defstruct name: nil

  defp new(name) do
    %DomainEvent{name: name}
  end

  def venue_changed do
    %DomainEvent{name: :venue_changed}
  end
end
