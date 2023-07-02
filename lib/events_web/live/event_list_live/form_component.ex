defmodule EventsWeb.EventListLive.FormComponent do
  use EventsWeb, :live_component

  alias Events.EventLists

  @impl true
  def update(%{event_list: event_list} = assigns, socket) do
    changeset = EventLists.change_event_list(event_list)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"event_list" => event_list_params}, socket) do
    changeset =
      socket.assigns.event_list
      |> EventLists.change_event_list(event_list_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"event_list" => event_list_params}, socket) do
    save_event_list(socket, socket.assigns.action, event_list_params)
  end

  defp save_event_list(socket, :edit, event_list_params) do
    case EventLists.update_event_list(socket.assigns.event_list, event_list_params) do
      {:ok, _event_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Event list updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_event_list(socket, :new, event_list_params) do
    case EventLists.create_event_list(event_list_params) do
      {:ok, _event_list} ->
        {:noreply,
         socket
         |> put_flash(:info, "Event list created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
