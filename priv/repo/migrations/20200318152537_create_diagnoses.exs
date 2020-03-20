defmodule Virusmap.Repo.Migrations.CreateDiagnoses do
  use Ecto.Migration

  def change do
    create table(:diagnoses) do
      add :name, :string

      timestamps()
    end
  end
end
