defmodule Events.EventListsTest do
  use Events.DataCase

  alias Events.EventLists

  describe "eventslists" do
    alias Events.EventLists.EventList

    import Events.EventListsFixtures

    @invalid_attrs %{approvalone: nil, approvaltwo: nil, doe: nil, images: nil, name: nil, slots: nil, status: nil, time: nil}

    test "list_eventslists/0 returns all eventslists" do
      event_list = event_list_fixture()
      assert EventLists.list_eventslists() == [event_list]
    end

    test "get_event_list!/1 returns the event_list with given id" do
      event_list = event_list_fixture()
      assert EventLists.get_event_list!(event_list.id) == event_list
    end

    test "create_event_list/1 with valid data creates a event_list" do
      valid_attrs = %{approvalone: "some approvalone", approvaltwo: "some approvaltwo", doe: ~D[2023-07-01], images: "some images", name: "some name", slots: 42, status: "some status", time: "some time"}

      assert {:ok, %EventList{} = event_list} = EventLists.create_event_list(valid_attrs)
      assert event_list.approvalone == "some approvalone"
      assert event_list.approvaltwo == "some approvaltwo"
      assert event_list.doe == ~D[2023-07-01]
      assert event_list.images == "some images"
      assert event_list.name == "some name"
      assert event_list.slots == 42
      assert event_list.status == "some status"
      assert event_list.time == "some time"
    end

    test "create_event_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = EventLists.create_event_list(@invalid_attrs)
    end

    test "update_event_list/2 with valid data updates the event_list" do
      event_list = event_list_fixture()
      update_attrs = %{approvalone: "some updated approvalone", approvaltwo: "some updated approvaltwo", doe: ~D[2023-07-02], images: "some updated images", name: "some updated name", slots: 43, status: "some updated status", time: "some updated time"}

      assert {:ok, %EventList{} = event_list} = EventLists.update_event_list(event_list, update_attrs)
      assert event_list.approvalone == "some updated approvalone"
      assert event_list.approvaltwo == "some updated approvaltwo"
      assert event_list.doe == ~D[2023-07-02]
      assert event_list.images == "some updated images"
      assert event_list.name == "some updated name"
      assert event_list.slots == 43
      assert event_list.status == "some updated status"
      assert event_list.time == "some updated time"
    end

    test "update_event_list/2 with invalid data returns error changeset" do
      event_list = event_list_fixture()
      assert {:error, %Ecto.Changeset{}} = EventLists.update_event_list(event_list, @invalid_attrs)
      assert event_list == EventLists.get_event_list!(event_list.id)
    end

    test "delete_event_list/1 deletes the event_list" do
      event_list = event_list_fixture()
      assert {:ok, %EventList{}} = EventLists.delete_event_list(event_list)
      assert_raise Ecto.NoResultsError, fn -> EventLists.get_event_list!(event_list.id) end
    end

    test "change_event_list/1 returns a event_list changeset" do
      event_list = event_list_fixture()
      assert %Ecto.Changeset{} = EventLists.change_event_list(event_list)
    end
  end
end
