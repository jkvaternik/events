defmodule EventsBoardWeb.PageController do
  use EventsBoardWeb, :controller

  def get_events(conn) do
    user = conn.assigns[:current_user]
    events = EventsBoard.Events.list_events()
    if user do
      Enum.filter(events, fn event ->
        event.user_id == user.id ||
        Enum.any?(event.invites, fn inv -> inv.email == user.email end)
      end)
    else
      nil
    end
  end

  def index(conn, _params) do
    events = get_events(conn)
    render(conn, "index.html", events: events)
  end
end
