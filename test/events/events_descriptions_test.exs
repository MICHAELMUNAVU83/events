defmodule Events.EventsDescriptionsTest do
  use Events.DataCase

  alias Events.EventsDescriptions

  describe "events_descriptions" do
    alias Events.EventsDescriptions.EventDescription

    import Events.EventsDescriptionsFixtures

    @invalid_attrs %{description: nil, status: nil}

    test "list_events_descriptions/0 returns all events_descriptions" do
      event_description = event_description_fixture()
      assert EventsDescriptions.list_events_descriptions() == [event_description]
    end

    test "get_event_description!/1 returns the event_description with given id" do
      event_description = event_description_fixture()
      assert EventsDescriptions.get_event_description!(event_description.id) == event_description
    end

    test "create_event_description/1 with valid data creates a event_description" do
      valid_attrs = %{description: "some description", status: "some status"}

      assert {:ok, %EventDescription{} = event_description} =
               EventsDescriptions.create_event_description(valid_attrs)

      assert event_description.description == "some description"
      assert event_description.status == "some status"
    end

    test "create_event_description/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               EventsDescriptions.create_event_description(@invalid_attrs)
    end

    test "update_event_description/2 with valid data updates the event_description" do
      event_description = event_description_fixture()
      update_attrs = %{description: "some updated description", status: "some updated status"}

      assert {:ok, %EventDescription{} = event_description} =
               EventsDescriptions.update_event_description(event_description, update_attrs)

      assert event_description.description == "some updated description"
      assert event_description.status == "some updated status"
    end

    test "update_event_description/2 with invalid data returns error changeset" do
      event_description = event_description_fixture()

      assert {:error, %Ecto.Changeset{}} =
               EventsDescriptions.update_event_description(event_description, @invalid_attrs)

      assert event_description == EventsDescriptions.get_event_description!(event_description.id)
    end

    test "delete_event_description/1 deletes the event_description" do
      event_description = event_description_fixture()

      assert {:ok, %EventDescription{}} =
               EventsDescriptions.delete_event_description(event_description)

      assert_raise Ecto.NoResultsError, fn ->
        EventsDescriptions.get_event_description!(event_description.id)
      end
    end

    test "change_event_description/1 returns a event_description changeset" do
      event_description = event_description_fixture()
      assert %Ecto.Changeset{} = EventsDescriptions.change_event_description(event_description)
    end
  end
end
