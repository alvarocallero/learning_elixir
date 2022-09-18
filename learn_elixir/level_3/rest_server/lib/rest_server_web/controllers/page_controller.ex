defmodule RestServerWeb.PageController do
  use RestServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
