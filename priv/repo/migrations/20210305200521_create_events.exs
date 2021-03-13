defmodule EventsBoard.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :date, :utc_datetime
      add :desc, :text
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
