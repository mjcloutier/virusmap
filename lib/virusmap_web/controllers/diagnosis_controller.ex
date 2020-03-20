defmodule VirusmapWeb.DiagnosisController do
  use VirusmapWeb, :controller

  alias Virusmap.{Diagnose, Diagnose.Diagnosis}

  def index(conn, _params) do
    diagnoses = Diagnose.list_diagnoses()
    render(conn, "index.html", diagnoses: diagnoses)
  end

  def new(conn, _params) do
    changeset = Diagnose.change_diagnosis(%Diagnosis{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"diagnosis" => diagnosis_params}) do
    case Diagnose.create_diagnosis(diagnosis_params) do
      {:ok, diagnosis} ->
        conn
        |> put_flash(:info, "Diagnosis created successfully.")
        |> redirect(to: Routes.diagnosis_path(conn, :show, diagnosis))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    diagnosis = Diagnose.get_diagnosis!(id)
    render(conn, "show.html", diagnosis: diagnosis)
  end

  def edit(conn, %{"id" => id}) do
    diagnosis = Diagnose.get_diagnosis!(id)
    changeset = Diagnose.change_diagnosis(diagnosis)
    render(conn, "edit.html", diagnosis: diagnosis, changeset: changeset)
  end

  def update(conn, %{"id" => id, "diagnosis" => diagnosis_params}) do
    diagnosis = Diagnose.get_diagnosis!(id)

    case Diagnose.update_diagnosis(diagnosis, diagnosis_params) do
      {:ok, diagnosis} ->
        conn
        |> put_flash(:info, "Diagnosis updated successfully.")
        |> redirect(to: Routes.diagnosis_path(conn, :show, diagnosis))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", diagnosis: diagnosis, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    diagnosis = Diagnose.get_diagnosis!(id)
    {:ok, _diagnosis} = Diagnose.delete_diagnosis(diagnosis)

    conn
    |> put_flash(:info, "Diagnosis deleted successfully.")
    |> redirect(to: Routes.diagnosis_path(conn, :index))
  end
end
