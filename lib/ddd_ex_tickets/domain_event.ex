defmodule DddExTickets.DomainEvent do
  alias DddExTickets.DomainEvent

  defstruct name: nil

  def new(name) do
    %DomainEvent{name: name}
  end
end
