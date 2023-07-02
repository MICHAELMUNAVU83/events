defmodule Events.EventLists do
  @moduledoc """
  The EventLists context.
  """

  import Ecto.Query, warn: false
  alias Events.Repo

  alias Events.EventLists.EventList

  @doc """
  Returns the list of eventslists.

  ## Examples

      iex> list_eventslists()
      [%EventList{}, ...]

  """
  def list_eventslists do
    Repo.all(EventList)
  end

  @doc """
  Gets a single event_list.

  Raises `Ecto.NoResultsError` if the Event list does not exist.

  ## Examples

      iex> get_event_list!(123)
      %EventList{}

      iex> get_event_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_list!(id), do: Repo.get!(EventList, id)

  @doc """
  Creates a event_list.

  ## Examples

      iex> create_event_list(%{field: value})
      {:ok, %EventList{}}

      iex> create_event_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_list(attrs \\ %{}) do
    %EventList{}
    |> EventList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_list.

  ## Examples

      iex> update_event_list(event_list, %{field: new_value})
      {:ok, %EventList{}}

      iex> update_event_list(event_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_list(%EventList{} = event_list, attrs) do
    event_list
    |> EventList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event_list.

  ## Examples

      iex> delete_event_list(event_list)
      {:ok, %EventList{}}

      iex> delete_event_list(event_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_list(%EventList{} = event_list) do
    Repo.delete(event_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_list changes.

  ## Examples

      iex> change_event_list(event_list)
      %Ecto.Changeset{data: %EventList{}}

  """
  def change_event_list(%EventList{} = event_list, attrs \\ %{}) do
    EventList.changeset(event_list, attrs)
  end
end
