defmodule EventsBoard.Repo do
  use Ecto.Repo,
    otp_app: :events_board,
    adapter: Ecto.Adapters.Postgres
end
