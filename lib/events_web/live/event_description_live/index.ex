defmodule EventsWeb.EventDescriptionLive.Index do
  use EventsWeb, :dashboard_live_view

  alias Events.EventsDescriptions
  alias Events.EventsDescriptions.EventDescription

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :events_descriptions, list_events_descriptions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event description")
    |> assign(:event_description, EventsDescriptions.get_event_description!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event description")
    |> assign(:event_description, %EventDescription{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Events descriptions")
    |> assign(:event_description, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_description = EventsDescriptions.get_event_description!(id)
    {:ok, _} = EventsDescriptions.delete_event_description(event_description)

    {:noreply, assign(socket, :events_descriptions, list_events_descriptions())}
  end

  defp list_events_descriptions do
    EventsDescriptions.list_events_descriptions()
  end
end
