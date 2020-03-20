defmodule VirusmapWeb.VirusController do
  use VirusmapWeb, :controller

  alias Virusmap.{Ailment, Ailment.Virus}

  def index(conn, _params) do
    viruses = Ailment.list_viruses()
    render(conn, "index.html", viruses: viruses)
  end

  def new(conn, _params) do
    changeset = Ailment.change_virus(%Virus{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"virus" => virus_params}) do
    case Ailment.create_virus(virus_params) do
      {:ok, virus} ->
        conn
        |> put_flash(:info, "Virus created successfully.")
        |> redirect(to: Routes.virus_path(conn, :show, virus))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    virus = Ailment.get_virus!(id)
    render(conn, "show.html", virus: virus)
  end

  def edit(conn, %{"id" => id}) do
    virus = Ailment.get_virus!(id)
    changeset = Ailment.change_virus(virus)
    render(conn, "edit.html", virus: virus, changeset: changeset)
  end

  def update(conn, %{"id" => id, "virus" => virus_params}) do
    virus = Ailment.get_virus!(id)

    case Ailment.update_virus(virus, virus_params) do
      {:ok, virus} ->
        conn
        |> put_flash(:info, "Virus updated successfully.")
        |> redirect(to: Routes.virus_path(conn, :show, virus))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", virus: virus, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    virus = Ailment.get_virus!(id)
    {:ok, _virus} = Ailment.delete_virus(virus)

    conn
    |> put_flash(:info, "Virus deleted successfully.")
    |> redirect(to: Routes.virus_path(conn, :index))
  end
end
