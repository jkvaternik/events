defmodule EventsBoard.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :resp, :string
    field :email, :string
    belongs_to :event, EventsBoard.Events.Event

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:resp, :event_id, :email])
    |> validate_required([:resp, :event_id, :email])
  end
end
