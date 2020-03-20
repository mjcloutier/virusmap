defmodule VirusmapWeb.Router do
  use VirusmapWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowInvitation, PowPersistentSession]

  # PIPELINES
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Turbolinks
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  # Bamboo Mailer View (local development)
  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  # ROUTES
  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end

  # UNPROTECTED
  scope "/", VirusmapWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/donate", PageController, :donate
  end

  scope "/api", VirusmapWeb do
    pipe_through :api
  end

  # PROTECTED
  scope "/", VirusmapWeb do
    pipe_through [:browser, :protected]

    resources "/diagnoses", DiagnosisController
    resources "/viruses", VirusController
  end
end
