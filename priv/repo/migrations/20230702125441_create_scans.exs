defmodule Events.Repo.Migrations.CreateScans do
  use Ecto.Migration

  def change do
    create table(:scans) do
      add :status, :string

      timestamps()
    end
  end
end
