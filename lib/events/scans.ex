defmodule Events.Scans do
  @moduledoc """
  The Scans context.
  """

  import Ecto.Query, warn: false
  alias Events.Repo

  alias Events.Scans.Scan

  @doc """
  Returns the list of scans.

  ## Examples

      iex> list_scans()
      [%Scan{}, ...]

  """
  def list_scans do
    Repo.all(Scan)
  end

  @doc """
  Gets a single scan.

  Raises `Ecto.NoResultsError` if the Scan does not exist.

  ## Examples

      iex> get_scan!(123)
      %Scan{}

      iex> get_scan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scan!(id), do: Repo.get!(Scan, id)

  @doc """
  Creates a scan.

  ## Examples

      iex> create_scan(%{field: value})
      {:ok, %Scan{}}

      iex> create_scan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scan(attrs \\ %{}) do
    %Scan{}
    |> Scan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scan.

  ## Examples

      iex> update_scan(scan, %{field: new_value})
      {:ok, %Scan{}}

      iex> update_scan(scan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scan(%Scan{} = scan, attrs) do
    scan
    |> Scan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scan.

  ## Examples

      iex> delete_scan(scan)
      {:ok, %Scan{}}

      iex> delete_scan(scan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scan(%Scan{} = scan) do
    Repo.delete(scan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scan changes.

  ## Examples

      iex> change_scan(scan)
      %Ecto.Changeset{data: %Scan{}}

  """
  def change_scan(%Scan{} = scan, attrs \\ %{}) do
    Scan.changeset(scan, attrs)
  end
end
