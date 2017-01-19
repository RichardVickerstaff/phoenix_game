defmodule PhoenixGame.PageController do
  use PhoenixGame.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
