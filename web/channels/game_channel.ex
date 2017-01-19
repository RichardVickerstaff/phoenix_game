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
    Game.Cache.set("1234", new_game_state())
    broadcast! socket, "update_state", game_state()
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
    Game.Cache.fetch("1234", %{color: "#6173F4", x: 0, y: 0, z: -5 })
  end

  defp new_game_state do
    state = game_state()
    Map.put(state, :x, state.x + 1)
  end
end
