defmodule EventsWeb.ScanLive.Index do
  use EventsWeb, :live_view

  alias Events.Scans
  alias Events.Scans.Scan

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :scans, list_scans())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Scan")
    |> assign(:scan, Scans.get_scan!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Scan")
    |> assign(:scan, %Scan{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Scans")
    |> assign(:scan, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    scan = Scans.get_scan!(id)
    {:ok, _} = Scans.delete_scan(scan)

    {:noreply, assign(socket, :scans, list_scans())}
  end

  defp list_scans do
    Scans.list_scans()
  end
end
