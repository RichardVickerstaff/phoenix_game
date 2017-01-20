defmodule PhoenixGame.PageController do
  use PhoenixGame.Web, :controller

  def index(conn, params) do
    render conn, "index.html", %{game_id: params["game_id"]}
  end
end
