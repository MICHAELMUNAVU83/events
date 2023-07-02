defmodule Events.Tickets.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tickets" do
    field :image, :string
    field :status, :string
    field :ticketid, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:ticketid, :type, :image, :status])
    |> validate_required([:ticketid, :type, :image, :status])
  end
end
