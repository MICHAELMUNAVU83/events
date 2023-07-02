defmodule Events.Repo.Migrations.CreateEventsDescriptions do
  use Ecto.Migration

  def change do
    create table(:events_descriptions) do
      add :description, :string
      add :status, :string

      timestamps()
    end
  end
end
