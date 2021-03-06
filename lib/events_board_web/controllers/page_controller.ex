defmodule EventsBoardWeb.PageController do
  use EventsBoardWeb, :controller

  def index(conn, _params) do
    events = EventsBoard.Events.list_events()
    render(conn, "index.html", events: events)
  end
end
