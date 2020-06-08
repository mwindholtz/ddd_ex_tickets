defmodule DddExTickets.EventBus do
  @topic "DddExTickets.EventBus"

  alias Phoenix.PubSub
  alias DddExTickets.DomainEvent
  @pubsub_name DddExTickets.PubSub

  def subscribe do
    PubSub.subscribe(@pubsub_name, @topic)
  end

  def publish(%DomainEvent{} = domain_event) do
    PubSub.broadcast(@pubsub_name, @topic, domain_event)
  end
end
