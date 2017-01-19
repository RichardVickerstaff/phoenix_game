defmodule PhoenixGame.GameChannel do
  use PhoenixGame.Web, :channel

  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, game_state(), socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("action", payload, socket) do
    broadcast! socket, "update_state", new_game_state()
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  defp game_state do
    %{color: "#6173F4", x: 0, y: 0, z: -5 }
  end

  defp new_game_state do
    %{color: "#6173F4", x: 0, y: 2, z: -5 }
  end
end
