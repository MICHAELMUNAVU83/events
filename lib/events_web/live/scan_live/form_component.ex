defmodule EventsWeb.ScanLive.FormComponent do
  use EventsWeb, :live_component
  alias Events.Scans

  @impl true
  def update(%{scan: scan} = assigns, socket) do
    changeset = Scans.change_scan(scan)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"scan" => scan_params}, socket) do
    changeset =
      socket.assigns.scan
      |> Scans.change_scan(scan_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"scan" => scan_params}, socket) do
    save_scan(socket, socket.assigns.action, scan_params)
  end

  defp save_scan(socket, :edit, scan_params) do
    case Scans.update_scan(socket.assigns.scan, scan_params) do
      {:ok, _scan} ->
        {:noreply,
         socket
         |> put_flash(:info, "Scan updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_scan(socket, :new, scan_params) do
    case Scans.create_scan(scan_params) do
      {:ok, _scan} ->
        {:noreply,
         socket
         |> put_flash(:info, "Scan created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
