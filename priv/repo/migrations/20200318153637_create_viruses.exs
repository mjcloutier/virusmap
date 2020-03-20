defmodule Virusmap.Repo.Migrations.CreateViruses do
  use Ecto.Migration

  def change do
    create table(:viruses) do
      add :address, :string
      add :address2, :string
      add :city, :string
      add :country, :string
      add :cured_at, :naive_datetime
      add :diagnosed, :boolean, default: false, null: false
      add :lat, :string
      add :lng, :string
      add :location, :string
      add :state, :string
      add :symptoms, :map
      add :diagnosis_id, references(:diagnoses, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:viruses, [:diagnosis_id])
    create index(:viruses, [:user_id])
  end
end
