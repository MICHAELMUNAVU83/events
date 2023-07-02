defmodule EventsWeb.NotificationLiveTest do
  use EventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Events.NotificationsFixtures

  @create_attrs %{
    amount: "some amount",
    description: "some description",
    status: "some status",
    type: "some type"
  }
  @update_attrs %{
    amount: "some updated amount",
    description: "some updated description",
    status: "some updated status",
    type: "some updated type"
  }
  @invalid_attrs %{amount: nil, description: nil, status: nil, type: nil}

  defp create_notification(_) do
    notification = notification_fixture()
    %{notification: notification}
  end

  describe "Index" do
    setup [:create_notification]

    test "lists all notifications", %{conn: conn, notification: notification} do
      {:ok, _index_live, html} = live(conn, Routes.notification_index_path(conn, :index))

      assert html =~ "Listing Notifications"
      assert html =~ notification.amount
    end

    test "saves new notification", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.notification_index_path(conn, :index))

      assert index_live |> element("a", "New Notification") |> render_click() =~
               "New Notification"

      assert_patch(index_live, Routes.notification_index_path(conn, :new))

      assert index_live
             |> form("#notification-form", notification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#notification-form", notification: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notification_index_path(conn, :index))

      assert html =~ "Notification created successfully"
      assert html =~ "some amount"
    end

    test "updates notification in listing", %{conn: conn, notification: notification} do
      {:ok, index_live, _html} = live(conn, Routes.notification_index_path(conn, :index))

      assert index_live |> element("#notification-#{notification.id} a", "Edit") |> render_click() =~
               "Edit Notification"

      assert_patch(index_live, Routes.notification_index_path(conn, :edit, notification))

      assert index_live
             |> form("#notification-form", notification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#notification-form", notification: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notification_index_path(conn, :index))

      assert html =~ "Notification updated successfully"
      assert html =~ "some updated amount"
    end

    test "deletes notification in listing", %{conn: conn, notification: notification} do
      {:ok, index_live, _html} = live(conn, Routes.notification_index_path(conn, :index))

      assert index_live
             |> element("#notification-#{notification.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#notification-#{notification.id}")
    end
  end

  describe "Show" do
    setup [:create_notification]

    test "displays notification", %{conn: conn, notification: notification} do
      {:ok, _show_live, html} =
        live(conn, Routes.notification_show_path(conn, :show, notification))

      assert html =~ "Show Notification"
      assert html =~ notification.amount
    end

    test "updates notification within modal", %{conn: conn, notification: notification} do
      {:ok, show_live, _html} =
        live(conn, Routes.notification_show_path(conn, :show, notification))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Notification"

      assert_patch(show_live, Routes.notification_show_path(conn, :edit, notification))

      assert show_live
             |> form("#notification-form", notification: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#notification-form", notification: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.notification_show_path(conn, :show, notification))

      assert html =~ "Notification updated successfully"
      assert html =~ "some updated amount"
    end
  end
end
