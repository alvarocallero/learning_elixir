defmodule OverviewProjectWeb.PageController do
  use OverviewProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
