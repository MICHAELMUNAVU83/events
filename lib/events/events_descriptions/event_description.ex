defmodule Events.EventsDescriptions.EventDescription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events_descriptions" do
    field :description, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(event_description, attrs) do
    event_description
    |> cast(attrs, [:description, :status])
    |> validate_required([:description, :status])
  end
end
