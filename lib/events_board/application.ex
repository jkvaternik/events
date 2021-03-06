defmodule EventsBoard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EventsBoard.Repo,
      # Start the Telemetry supervisor
      EventsBoardWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EventsBoard.PubSub},
      # Start the Endpoint (http/https)
      EventsBoardWeb.Endpoint
      # Start a worker by calling: EventsBoard.Worker.start_link(arg)
      # {EventsBoard.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EventsBoard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EventsBoardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
