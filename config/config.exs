# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phxy,
  ecto_repos: [Phxy.Repo]


config :phxy, :pow,
  user: Phxy.Users.User,
  repo: Phxy.Repo


# Configures the endpoint
config :phxy, PhxyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iVr5sp/sJSmwqVTAErXWXlksKUPHRICBcc4pHlzkOZYEbV9CCSSpbipb1ORq/nQ5",
  render_errors: [view: PhxyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Phxy.PubSub,
  live_view: [signing_salt: "HaEX9H6z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
