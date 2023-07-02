defmodule EventsWeb.EventListLive.Index do
  use EventsWeb, :live_view

  alias Events.EventLists
  alias Events.EventLists.EventList

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :eventslists, list_eventslists())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event list")
    |> assign(:event_list, EventLists.get_event_list!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event list")
    |> assign(:event_list, %EventList{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Eventslists")
    |> assign(:event_list, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event_list = EventLists.get_event_list!(id)
    {:ok, _} = EventLists.delete_event_list(event_list)

    {:noreply, assign(socket, :eventslists, list_eventslists())}
  end

  defp list_eventslists do
    EventLists.list_eventslists()
  end
end
