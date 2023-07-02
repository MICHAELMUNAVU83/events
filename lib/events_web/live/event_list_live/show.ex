defmodule EventsWeb.EventListLive.Show do
  use EventsWeb, :live_view

  alias Events.EventLists

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event_list, EventLists.get_event_list!(id))}
  end

  defp page_title(:show), do: "Show Event list"
  defp page_title(:edit), do: "Edit Event list"
end
