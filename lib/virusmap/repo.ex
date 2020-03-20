defmodule Virusmap.Repo do
  use Ecto.Repo,
    otp_app: :virusmap,
    adapter: Ecto.Adapters.Postgres
end
