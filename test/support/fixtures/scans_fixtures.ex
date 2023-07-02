defmodule Events.ScansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Events.Scans` context.
  """

  @doc """
  Generate a scan.
  """
  def scan_fixture(attrs \\ %{}) do
    {:ok, scan} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> Events.Scans.create_scan()

    scan
  end
end
