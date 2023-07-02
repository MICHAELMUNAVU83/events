defmodule Events.Repo.Migrations.CreateEventslists do
  use Ecto.Migration

  def change do
    create table(:eventslists) do
      add :name, :string
      add :doe, :date
      add :time, :string
      add :images, :string
      add :approvalone, :string
      add :approvaltwo, :string
      add :slots, :integer
      add :status, :string

      timestamps()
    end
  end
end
