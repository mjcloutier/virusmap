defmodule Virusmap.Diagnose.Diagnosis do
  use Ecto.Schema
  import Ecto.Changeset

  schema "diagnoses" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(diagnosis, attrs) do
    diagnosis
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
