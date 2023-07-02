defmodule EventsWeb.ScanLiveTest do
  use EventsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Events.ScansFixtures

  @create_attrs %{status: "some status"}
  @update_attrs %{status: "some updated status"}
  @invalid_attrs %{status: nil}

  defp create_scan(_) do
    scan = scan_fixture()
    %{scan: scan}
  end

  describe "Index" do
    setup [:create_scan]

    test "lists all scans", %{conn: conn, scan: scan} do
      {:ok, _index_live, html} = live(conn, Routes.scan_index_path(conn, :index))

      assert html =~ "Listing Scans"
      assert html =~ scan.status
    end

    test "saves new scan", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.scan_index_path(conn, :index))

      assert index_live |> element("a", "New Scan") |> render_click() =~
               "New Scan"

      assert_patch(index_live, Routes.scan_index_path(conn, :new))

      assert index_live
             |> form("#scan-form", scan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#scan-form", scan: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.scan_index_path(conn, :index))

      assert html =~ "Scan created successfully"
      assert html =~ "some status"
    end

    test "updates scan in listing", %{conn: conn, scan: scan} do
      {:ok, index_live, _html} = live(conn, Routes.scan_index_path(conn, :index))

      assert index_live |> element("#scan-#{scan.id} a", "Edit") |> render_click() =~
               "Edit Scan"

      assert_patch(index_live, Routes.scan_index_path(conn, :edit, scan))

      assert index_live
             |> form("#scan-form", scan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#scan-form", scan: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.scan_index_path(conn, :index))

      assert html =~ "Scan updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes scan in listing", %{conn: conn, scan: scan} do
      {:ok, index_live, _html} = live(conn, Routes.scan_index_path(conn, :index))

      assert index_live |> element("#scan-#{scan.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#scan-#{scan.id}")
    end
  end

  describe "Show" do
    setup [:create_scan]

    test "displays scan", %{conn: conn, scan: scan} do
      {:ok, _show_live, html} = live(conn, Routes.scan_show_path(conn, :show, scan))

      assert html =~ "Show Scan"
      assert html =~ scan.status
    end

    test "updates scan within modal", %{conn: conn, scan: scan} do
      {:ok, show_live, _html} = live(conn, Routes.scan_show_path(conn, :show, scan))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Scan"

      assert_patch(show_live, Routes.scan_show_path(conn, :edit, scan))

      assert show_live
             |> form("#scan-form", scan: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#scan-form", scan: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.scan_show_path(conn, :show, scan))

      assert html =~ "Scan updated successfully"
      assert html =~ "some updated status"
    end
  end
end
