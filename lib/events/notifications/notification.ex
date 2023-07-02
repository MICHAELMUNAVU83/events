defmodule Events.Notifications.Notification do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notifications" do
    field :amount, :string
    field :description, :string
    field :status, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(notification, attrs) do
    notification
    |> cast(attrs, [:description, :type, :amount, :status])
    |> validate_required([:description, :type, :amount, :status])
  end
end
