defmodule EventsWeb.EventDescriptionLive.FormComponent do
  use EventsWeb, :dashboard_live_view

  alias Events.EventsDescriptions

  @impl true
  def update(%{event_description: event_description} = assigns, socket) do
    changeset = EventsDescriptions.change_event_description(event_description)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"event_description" => event_description_params}, socket) do
    changeset =
      socket.assigns.event_description
      |> EventsDescriptions.change_event_description(event_description_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"event_description" => event_description_params}, socket) do
    save_event_description(socket, socket.assigns.action, event_description_params)
  end

  defp save_event_description(socket, :edit, event_description_params) do
    case EventsDescriptions.update_event_description(
           socket.assigns.event_description,
           event_description_params
         ) do
      {:ok, _event_description} ->
        {:noreply,
         socket
         |> put_flash(:info, "Event description updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_event_description(socket, :new, event_description_params) do
    case EventsDescriptions.create_event_description(event_description_params) do
      {:ok, _event_description} ->
        {:noreply,
         socket
         |> put_flash(:info, "Event description created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
