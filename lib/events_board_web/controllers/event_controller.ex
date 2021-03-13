defmodule EventsBoardWeb.EventController do
  use EventsBoardWeb, :controller

  alias EventsBoard.Events
  alias EventsBoard.Events.Event

  alias EventsBoard.Comments
  alias EventsBoard.Invites

  alias EventsBoardWeb.Plugs
  plug Plugs.RequireUser when action in [:new, :edit, :create, :update]

  plug :fetch_post when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    event_params = event_params
    |> Map.put("user_id", conn.assigns[:current_user].id)

    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def fetch_post(conn, _args) do
    id = conn.params["id"]
    IO.inspect(id)
    event = Events.get_event!(id)
    assign(conn, :event, event)
  end

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    event = conn.assigns[:event]

    if user.id == event.user_id do
      conn
    else
      conn
      |> put_flash(:error, "You are not the owner of this element.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def show(conn, %{"id" => _id}) do
    event = Events.load_comments_invites(conn.assigns[:event])
    comm = %Comments.Comment{
      event_id: event.id,
      user_id: current_user_id(conn)
    }
    inv = %Invites.Invite{
      event_id: event.id
    }
    new_comment = Comments.change_comment(comm)
    new_invite = Invites.change_invite(inv)
    render(conn, "show.html", event: event, new_comment: new_comment, new_invite: new_invite)
  end

  def edit(conn, %{"id" => _id}) do
    event = conn.assigns[:event]
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => _id, "event" => event_params}) do
    event = conn.assigns[:event]

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => _id}) do
    event = conn.assigns[:event]
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end
end
