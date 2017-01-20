defmodule PhoenixGame.GameChannel do
  require Logger
  use PhoenixGame.Web, :channel

  def join("game:" <> game_id, payload, socket) do
    if authorized?(payload) do
      {:ok, game_state(game_id), socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("action", payload, socket) do
    game_id = payload["body"]["game_id"]
    Game.Cache.set(game_id, new_game_state(payload["body"]))
    broadcast! socket, "update_state", game_state(game_id)
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

  defp game_state(game_id) do
    IO.puts game_id
    IO.inspect Game.Cache.get(game_id)
    state = Game.Cache.fetch(game_id, %{color: "#6173F4", x: 0, y: 0, z: -5, game_id: game_id })
    IO.inspect state
    IO.inspect Game.Cache.get(game_id)
    state
  end

  defp new_game_state(payload) do
    state = game_state(payload["game_id"])
    case payload["key_code"] do
      49 ->
        Map.put(state, :x, state.x - 1)
      50 ->
        Map.put(state, :x, state.x + 1)
      51 ->
        Map.put(state, :z, state.z + 1)
      52 ->
        Map.put(state, :z, state.z - 1)
    end
  end
end
