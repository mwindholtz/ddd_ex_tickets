defmodule DddExTicket.DomainEvent do
  alias DddExTicket.DomainEvent

  defstruct name: nil

  def new(name) do
    %DomainEvent{name: name}
  end
end
