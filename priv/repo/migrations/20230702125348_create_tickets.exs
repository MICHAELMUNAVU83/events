defmodule Events.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :ticketid, :string
      add :type, :string
      add :image, :string
      add :status, :string

      timestamps()
    end
  end
end
