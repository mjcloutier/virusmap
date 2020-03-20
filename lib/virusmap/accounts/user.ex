defmodule Virusmap.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  use Pow.Extension.Ecto.Schema, extensions: [PowResetPassword, PowPersistentSession]

  import Ecto.Changeset

  schema "users" do
    field :name, :string

    pow_user_fields()

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name])
    |> Ecto.Changeset.validate_required([:name])
    |> downcase_name()
  end

  defp downcase_name(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, name} -> put_change(changeset, :name, String.downcase(name))
      :error -> changeset
    end
  end
end
