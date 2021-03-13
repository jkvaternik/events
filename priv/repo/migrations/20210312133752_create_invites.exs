defmodule EventsBoard.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :resp, :string, null: false, default: "haven't responded"
      add :email, :string, null: false
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:invites, [:event_id])
  end
end
