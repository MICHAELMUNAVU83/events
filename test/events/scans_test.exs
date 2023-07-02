defmodule Events.ScansTest do
  use Events.DataCase

  alias Events.Scans

  describe "scans" do
    alias Events.Scans.Scan

    import Events.ScansFixtures

    @invalid_attrs %{status: nil}

    test "list_scans/0 returns all scans" do
      scan = scan_fixture()
      assert Scans.list_scans() == [scan]
    end

    test "get_scan!/1 returns the scan with given id" do
      scan = scan_fixture()
      assert Scans.get_scan!(scan.id) == scan
    end

    test "create_scan/1 with valid data creates a scan" do
      valid_attrs = %{status: "some status"}

      assert {:ok, %Scan{} = scan} = Scans.create_scan(valid_attrs)
      assert scan.status == "some status"
    end

    test "create_scan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Scans.create_scan(@invalid_attrs)
    end

    test "update_scan/2 with valid data updates the scan" do
      scan = scan_fixture()
      update_attrs = %{status: "some updated status"}

      assert {:ok, %Scan{} = scan} = Scans.update_scan(scan, update_attrs)
      assert scan.status == "some updated status"
    end

    test "update_scan/2 with invalid data returns error changeset" do
      scan = scan_fixture()
      assert {:error, %Ecto.Changeset{}} = Scans.update_scan(scan, @invalid_attrs)
      assert scan == Scans.get_scan!(scan.id)
    end

    test "delete_scan/1 deletes the scan" do
      scan = scan_fixture()
      assert {:ok, %Scan{}} = Scans.delete_scan(scan)
      assert_raise Ecto.NoResultsError, fn -> Scans.get_scan!(scan.id) end
    end

    test "change_scan/1 returns a scan changeset" do
      scan = scan_fixture()
      assert %Ecto.Changeset{} = Scans.change_scan(scan)
    end
  end
end
