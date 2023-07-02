defmodule Events.EventsDescriptions do
  @moduledoc """
  The EventsDescriptions context.
  """

  import Ecto.Query, warn: false
  alias Events.Repo

  alias Events.EventsDescriptions.EventDescription

  @doc """
  Returns the list of events_descriptions.

  ## Examples

      iex> list_events_descriptions()
      [%EventDescription{}, ...]

  """
  def list_events_descriptions do
    Repo.all(EventDescription)
  end

  @doc """
  Gets a single event_description.

  Raises `Ecto.NoResultsError` if the Event description does not exist.

  ## Examples

      iex> get_event_description!(123)
      %EventDescription{}

      iex> get_event_description!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event_description!(id), do: Repo.get!(EventDescription, id)

  @doc """
  Creates a event_description.

  ## Examples

      iex> create_event_description(%{field: value})
      {:ok, %EventDescription{}}

      iex> create_event_description(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event_description(attrs \\ %{}) do
    %EventDescription{}
    |> EventDescription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event_description.

  ## Examples

      iex> update_event_description(event_description, %{field: new_value})
      {:ok, %EventDescription{}}

      iex> update_event_description(event_description, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event_description(%EventDescription{} = event_description, attrs) do
    event_description
    |> EventDescription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a event_description.

  ## Examples

      iex> delete_event_description(event_description)
      {:ok, %EventDescription{}}

      iex> delete_event_description(event_description)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event_description(%EventDescription{} = event_description) do
    Repo.delete(event_description)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event_description changes.

  ## Examples

      iex> change_event_description(event_description)
      %Ecto.Changeset{data: %EventDescription{}}

  """
  def change_event_description(%EventDescription{} = event_description, attrs \\ %{}) do
    EventDescription.changeset(event_description, attrs)
  end
end
