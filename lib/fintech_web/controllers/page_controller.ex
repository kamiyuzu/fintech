defmodule FintechWeb.PageController do
  use FintechWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
