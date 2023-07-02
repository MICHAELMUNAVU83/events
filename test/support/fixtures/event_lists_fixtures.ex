defmodule Events.EventListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.EventLists` context.
  """

  @doc """
  Generate a event_list.
  """
  def event_list_fixture(attrs \\ %{}) do
    {:ok, event_list} =
      attrs
      |> Enum.into(%{
        approvalone: "some approvalone",
        approvaltwo: "some approvaltwo",
        doe: ~D[2023-07-01],
        images: "some images",
        name: "some name",
        slots: 42,
        status: "some status",
        time: "some time"
      })
      |> Events.EventLists.create_event_list()

    event_list
  end
end
