defmodule EventsWeb.EventDescriptionLiveTest do
  use EventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Events.EventsDescriptionsFixtures

  @create_attrs %{description: "some description", status: "some status"}
  @update_attrs %{description: "some updated description", status: "some updated status"}
  @invalid_attrs %{description: nil, status: nil}

  defp create_event_description(_) do
    event_description = event_description_fixture()
    %{event_description: event_description}
  end

  describe "Index" do
    setup [:create_event_description]

    test "lists all events_descriptions", %{conn: conn, event_description: event_description} do
      {:ok, _index_live, html} = live(conn, Routes.event_description_index_path(conn, :index))

      assert html =~ "Listing Events descriptions"
      assert html =~ event_description.description
    end

    test "saves new event_description", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.event_description_index_path(conn, :index))

      assert index_live |> element("a", "New Event description") |> render_click() =~
               "New Event description"

      assert_patch(index_live, Routes.event_description_index_path(conn, :new))

      assert index_live
             |> form("#event_description-form", event_description: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#event_description-form", event_description: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_description_index_path(conn, :index))

      assert html =~ "Event description created successfully"
      assert html =~ "some description"
    end

    test "updates event_description in listing", %{conn: conn, event_description: event_description} do
      {:ok, index_live, _html} = live(conn, Routes.event_description_index_path(conn, :index))

      assert index_live |> element("#event_description-#{event_description.id} a", "Edit") |> render_click() =~
               "Edit Event description"

      assert_patch(index_live, Routes.event_description_index_path(conn, :edit, event_description))

      assert index_live
             |> form("#event_description-form", event_description: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#event_description-form", event_description: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_description_index_path(conn, :index))

      assert html =~ "Event description updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes event_description in listing", %{conn: conn, event_description: event_description} do
      {:ok, index_live, _html} = live(conn, Routes.event_description_index_path(conn, :index))

      assert index_live |> element("#event_description-#{event_description.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#event_description-#{event_description.id}")
    end
  end

  describe "Show" do
    setup [:create_event_description]

    test "displays event_description", %{conn: conn, event_description: event_description} do
      {:ok, _show_live, html} = live(conn, Routes.event_description_show_path(conn, :show, event_description))

      assert html =~ "Show Event description"
      assert html =~ event_description.description
    end

    test "updates event_description within modal", %{conn: conn, event_description: event_description} do
      {:ok, show_live, _html} = live(conn, Routes.event_description_show_path(conn, :show, event_description))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Event description"

      assert_patch(show_live, Routes.event_description_show_path(conn, :edit, event_description))

      assert show_live
             |> form("#event_description-form", event_description: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#event_description-form", event_description: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.event_description_show_path(conn, :show, event_description))

      assert html =~ "Event description updated successfully"
      assert html =~ "some updated description"
    end
  end
end
