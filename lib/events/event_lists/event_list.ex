defmodule Events.EventLists.EventList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "eventslists" do
    field :approvalone, :string
    field :approvaltwo, :string
    field :doe, :date
    field :images, :string
    field :name, :string
    field :slots, :integer
    field :status, :string
    field :time, :string

    timestamps()
  end

  @doc false
  def changeset(event_list, attrs) do
    event_list
    |> cast(attrs, [:name, :doe, :time, :images, :approvalone, :approvaltwo, :slots, :status])
    |> validate_required([
      :name,
      :doe,
      :time,
      :images,
      :approvalone,
      :approvaltwo,
      :slots,
      :status
    ])
  end
end
