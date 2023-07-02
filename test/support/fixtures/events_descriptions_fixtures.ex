defmodule Events.EventsDescriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.EventsDescriptions` context.
  """

  @doc """
  Generate a event_description.
  """
  def event_description_fixture(attrs \\ %{}) do
    {:ok, event_description} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: "some status"
      })
      |> Events.EventsDescriptions.create_event_description()

    event_description
  end
end
