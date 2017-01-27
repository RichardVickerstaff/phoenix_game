defmodule PhoenixGame.GameChannel do
  require Logger
  use PhoenixGame.Web, :channel

  def join("game:" <> game_id, payload, socket) do
    if can_play?(payload) do
      {:ok, game_state(game_id), socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("setup", payload, socket) do
    game_id = payload["body"]["game_id"]
    Game.Cache.set(game_id, set_word(payload["body"]))
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
  defp can_play?(payload) do
    true
  end

  defp game_state(game_id) do
    {word, state} = Map.pop(Game.Cache.fetch(game_id, %{game_id: game_id }), :word, nil)
    state
  end

  defp set_word(payload) do
    game_state(payload["game_id"])
    |> Map.put(:word, payload["word"])
    |> Map.put(:word_guess, String.graphemes(payload["word"]))
  end
end
