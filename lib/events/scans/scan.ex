defmodule Events.Scans.Scan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scans" do
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(scan, attrs) do
    scan
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
