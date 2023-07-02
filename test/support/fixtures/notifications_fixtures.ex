defmodule Events.NotificationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.Notifications` context.
  """

  @doc """
  Generate a notification.
  """
  def notification_fixture(attrs \\ %{}) do
    {:ok, notification} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        description: "some description",
        status: "some status",
        type: "some type"
      })
      |> Events.Notifications.create_notification()

    notification
  end
end
