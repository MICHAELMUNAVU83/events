defmodule Events.Repo.Migrations.CreateNotifications do
  use Ecto.Migration

  def change do
    create table(:notifications) do
      add :description, :string
      add :type, :string
      add :amount, :string
      add :status, :string

      timestamps()
    end
  end
end
