# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :events_board,
  ecto_repos: [EventsBoard.Repo]

# Configures the endpoint
config :events_board, EventsBoardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XE11OdMekazyCwB89qk4/PFy86TbzOAXAXTyfUIc3uQAv4uJySYXdhen2CUdnCck",
  render_errors: [view: EventsBoardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: EventsBoard.PubSub,
  live_view: [signing_salt: "M3utfO+c"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
