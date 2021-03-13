defmodule EventsBoard.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :photo_hash, :string
    has_many :events, EventsBoard.Events.Event, on_delete: :delete_all
    has_many :comments, EventsBoard.Comments.Comment
    has_many :invites, EventsBoard.Invites.Invite, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :photo_hash])
    |> validate_required([:name, :email, :photo_hash])
  end
end
