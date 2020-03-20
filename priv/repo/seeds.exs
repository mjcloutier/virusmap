# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Virusmap.Repo.insert!(%Virusmap.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Virusmap.Repo
alias VirusMap.{Accounts.User, Viruses.Corona}

%User{
  name: "First User",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
}
|> Repo.insert!()
