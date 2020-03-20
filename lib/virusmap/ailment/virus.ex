defmodule Virusmap.Ailment.Virus do
  use Ecto.Schema
  import Ecto.Changeset

  schema "viruses" do
    field :address, :string
    field :address2, :string
    field :city, :string
    field :country, :string
    field :cured_at, :naive_datetime
    field :diagnosed, :boolean, default: false
    field :lat, :string
    field :lng, :string
    field :location, :string
    field :state, :string
    field :symptoms, :map
    field :diagnosis_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(virus, attrs) do
    virus
    |> cast(attrs, [
      :address,
      :address2,
      :city,
      :country,
      :cured_at,
      :diagnosed,
      :lat,
      :lng,
      :location,
      :state,
      :symptoms
    ])
    |> validate_required([:location])
  end
end
