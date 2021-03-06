defmodule EventsBoard.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :date, :utc_datetime
    field :desc, :string
    field :name, :string
    belongs_to :user, EventsBoard.Users.User
    has_many :comments, EventsBoard.Comments.Comment, on_delete: :delete_all
    has_many :invites, EventsBoard.Invites.Invite, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :date, :desc, :user_id])
    |> validate_required([:name, :date, :desc, :user_id])
  end
end
