# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :virusmap,
  ecto_repos: [Virusmap.Repo]

# Configures the endpoint
config :virusmap, VirusmapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "R7ys4dfhdARNWdhURHs8Edmv7DOOO0dUN051Of7LJODZRx1zKDCKX5Dj7DcAJA/W",
  render_errors: [view: VirusmapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Virusmap.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "jPwIQINz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure POW Auth
config :virusmap, :pow,
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  extensions: [PowResetPassword, PowPersistentSession, PowInvitation],
  mailer_backend: VirusmapWeb.PowMailer,
  repo: Virusmap.Repo,
  user: Virusmap.Accounts.User,
  web_module: VirusmapWeb,
  web_mailer_module: VirusmapWeb,
  routes_backend: VirusmapWeb.Pow.Routes

# Configure google_maps
config :google_maps,
  api_key: "AIzaSyDPud43hAXwyKatyGD_5iJon9xN5BDhpxo"

# Configure phoenix-active-link
config :phoenix_active_link, :defaults,
  wrap_tag: :li,
  class_active: "active",
  class_inactive: "not-active"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
