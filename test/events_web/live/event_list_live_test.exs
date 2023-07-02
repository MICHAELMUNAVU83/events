defmodule EventsWeb.EventListLiveTest do
  use EventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Events.EventListsFixtures

  @create_attrs %{approvalone: "some approvalone", approvaltwo: "some approvaltwo", doe: %{day: 1, month: 7, year: 2023}, images: "some images", name: "some name", slots: 42, status: "some status", time: "some time"}
  @update_attrs %{approvalone: "some updated approvalone", approvaltwo: "some updated approvaltwo", doe: %{day: 2, month: 7, year: 2023}, images: "some updated images", name: "some updated name", slots: 43, status: "some updated status", time: "some updated time"}
  @invalid_attrs %{approvalone: nil, approvaltwo: nil, doe: %{day: 30, month: 2, year: 2023}, images: nil, name: nil, slots: nil, status: nil, time: nil}

  defp create_event_list(_) do
    event_list = event_list_fixture()
    %{event_list: event_list}
  end

  describe "Index" do
    setup [:create_event_list]

    test "lists all eventslists", %{conn: conn, event_list: event_list} do
      {:ok, _index_live, html} = live(conn, Routes.event_list_index_path(conn, :index))

      assert html =~ "Listing Eventslists"
      assert html =~ event_list.approvalone
    end

    test "saves new event_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.event_list_index_path(conn, :index))

      assert index_live |> element("a", "New Event list") |> render_click() =~
               "New Event list"

      assert_patch(index_live, Routes.event_list_index_path(conn, :new))

      assert index_live
             |> form("#event_list-form", event_list: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#event_list-form", event_list: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_list_index_path(conn, :index))

      assert html =~ "Event list created successfully"
      assert html =~ "some approvalone"
    end

    test "updates event_list in listing", %{conn: conn, event_list: event_list} do
      {:ok, index_live, _html} = live(conn, Routes.event_list_index_path(conn, :index))

      assert index_live |> element("#event_list-#{event_list.id} a", "Edit") |> render_click() =~
               "Edit Event list"

      assert_patch(index_live, Routes.event_list_index_path(conn, :edit, event_list))

      assert index_live
             |> form("#event_list-form", event_list: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#event_list-form", event_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_list_index_path(conn, :index))

      assert html =~ "Event list updated successfully"
      assert html =~ "some updated approvalone"
    end

    test "deletes event_list in listing", %{conn: conn, event_list: event_list} do
      {:ok, index_live, _html} = live(conn, Routes.event_list_index_path(conn, :index))

      assert index_live |> element("#event_list-#{event_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event_list-#{event_list.id}")
    end
  end

  describe "Show" do
    setup [:create_event_list]

    test "displays event_list", %{conn: conn, event_list: event_list} do
      {:ok, _show_live, html} = live(conn, Routes.event_list_show_path(conn, :show, event_list))

      assert html =~ "Show Event list"
      assert html =~ event_list.approvalone
    end

    test "updates event_list within modal", %{conn: conn, event_list: event_list} do
      {:ok, show_live, _html} = live(conn, Routes.event_list_show_path(conn, :show, event_list))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event list"

      assert_patch(show_live, Routes.event_list_show_path(conn, :edit, event_list))

      assert show_live
             |> form("#event_list-form", event_list: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#event_list-form", event_list: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_list_show_path(conn, :show, event_list))

      assert html =~ "Event list updated successfully"
      assert html =~ "some updated approvalone"
    end
  end
end
