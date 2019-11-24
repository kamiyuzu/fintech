defmodule Fintech.Transferences do
  @moduledoc """
  The Transferences context.
  """

  import Ecto.Query, warn: false
  alias Fintech.Repo

  alias Fintech.Transferences.Transference

  @doc """
  Returns the list of transferences.

  ## Examples

      iex> list_transferences()
      [%Transference{}, ...]

  """
  def list_transferences do
    Repo.all(Transference)
  end

  @doc """
  Gets a single transference.

  Raises `Ecto.NoResultsError` if the Transference does not exist.

  ## Examples

      iex> get_transference!(123)
      %Transference{}

      iex> get_transference!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transference!(id), do: Repo.get!(Transference, id)

  @doc """
  Creates a transference.

  ## Examples

      iex> create_transference(%{field: value})
      {:ok, %Transference{}}

      iex> create_transference(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transference(attrs \\ %{}) do
    %Transference{}
    |> Transference.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transference.

  ## Examples

      iex> update_transference(transference, %{field: new_value})
      {:ok, %Transference{}}

      iex> update_transference(transference, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transference(%Transference{} = transference, attrs) do
    transference
    |> Transference.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Transference.

  ## Examples

      iex> delete_transference(transference)
      {:ok, %Transference{}}

      iex> delete_transference(transference)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transference(%Transference{} = transference) do
    Repo.delete(transference)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transference changes.

  ## Examples

      iex> change_transference(transference)
      %Ecto.Changeset{source: %Transference{}}

  """
  def change_transference(%Transference{} = transference) do
    Transference.changeset(transference, %{})
  end
end
