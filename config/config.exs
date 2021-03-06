# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app_liveview,
  ecto_repos: [AppLiveview.Repo]

# Configures the endpoint
config :app_liveview, AppLiveviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "93xVuz7St/p33Zee2NeuX4r/vW6OvCrIygmtZObYg7s0O5B2oOXg4r76O/iHiL8x",
  render_errors: [view: AppLiveviewWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AppLiveview.PubSub,
  live_view: [signing_salt: "rJYh6vJ6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
