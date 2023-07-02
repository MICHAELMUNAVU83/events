defmodule EventsWeb.EventDescriptionLive.Show do
  use EventsWeb, :live_view

  alias Events.EventsDescriptions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:event_description, EventsDescriptions.get_event_description!(id))}
  end

  defp page_title(:show), do: "Show Event description"
  defp page_title(:edit), do: "Edit Event description"
end