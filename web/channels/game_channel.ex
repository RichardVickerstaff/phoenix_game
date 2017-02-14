defmodule PhoenixGame.GameChannel do
  require Logger
  use PhoenixGame.Web, :channel

  def join("game:" <> game_id, payload, socket) do
    if can_play?(payload) do
      {:ok, return_game_state(game_id), socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("setup", payload, socket) do
    game_id = payload["body"]["game_id"]
    Game.Cache.set(game_id, set_word(payload["body"]))
    broadcast! socket, "update_state", return_game_state(game_id)
    {:noreply, socket}
  end

  def handle_in("guess", payload, socket) do
    game_id = payload["body"]["game_id"]
    Game.Cache.set(game_id, guess(payload["body"]))
    broadcast! socket, "update_state", return_game_state(game_id)
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
    Game.Cache.fetch(game_id, %{game_id: game_id, guesses: []})
  end

  defp return_game_state(game_id) do
    {word, state} = Map.pop(game_state(game_id), :word, nil)
    state
  end

  defp set_word(payload) do
    state = game_state(payload["game_id"])
    state = Map.put(state, :word, String.graphemes(payload["word"]))
    Map.put(state, :word_guess, Enum.map(String.graphemes(payload["word"]), fn(x) -> "_" end))
  end

  defp guess(payload) do
    state = game_state(payload["game_id"])
    Map.put(state, :guesses, state.guesses ++ [payload["guess"]])
  end






  defp replace_geuss(word_guess, word, guess) do
    [h_word_guess | t_word_guess] = word_guess
  end




end
