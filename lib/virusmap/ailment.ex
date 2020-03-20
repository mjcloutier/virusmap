defmodule Virusmap.Ailment do
  @moduledoc """
  The Ailment context.
  """

  import Ecto.Query, warn: false
  alias Virusmap.Repo

  alias Virusmap.Ailment.Virus

  @doc """
  Returns the list of viruses.

  ## Examples

      iex> list_viruses()
      [%Virus{}, ...]

  """
  def list_viruses do
    Repo.all(Virus)
  end

  @doc """
  Gets a single virus.

  Raises `Ecto.NoResultsError` if the Virus does not exist.

  ## Examples

      iex> get_virus!(123)
      %Virus{}

      iex> get_virus!(456)
      ** (Ecto.NoResultsError)

  """
  def get_virus!(id), do: Repo.get!(Virus, id)

  @doc """
  Creates a virus.

  ## Examples

      iex> create_virus(%{field: value})
      {:ok, %Virus{}}

      iex> create_virus(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_virus(attrs \\ %{}) do
    %Virus{}
    |> Virus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a virus.

  ## Examples

      iex> update_virus(virus, %{field: new_value})
      {:ok, %Virus{}}

      iex> update_virus(virus, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_virus(%Virus{} = virus, attrs) do
    virus
    |> Virus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a virus.

  ## Examples

      iex> delete_virus(virus)
      {:ok, %Virus{}}

      iex> delete_virus(virus)
      {:error, %Ecto.Changeset{}}

  """
  def delete_virus(%Virus{} = virus) do
    Repo.delete(virus)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking virus changes.

  ## Examples

      iex> change_virus(virus)
      %Ecto.Changeset{source: %Virus{}}

  """
  def change_virus(%Virus{} = virus) do
    Virus.changeset(virus, %{})
  end
end
