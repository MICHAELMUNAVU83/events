defmodule Events.TicketsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.Tickets` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        image: "some image",
        status: "some status",
        ticketid: "some ticketid",
        type: "some type"
      })
      |> Events.Tickets.create_ticket()

    ticket
  end
end
