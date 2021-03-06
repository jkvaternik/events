defmodule EventsBoard.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :date, :utc_datetime
      add :desc, :text

      timestamps()
    end

  end
end
