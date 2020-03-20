defmodule Virusmap.Factory do
  use ExMachina.Ecto, repo: Virusmap.Repo
  use Virusmap.UserFactory
end
