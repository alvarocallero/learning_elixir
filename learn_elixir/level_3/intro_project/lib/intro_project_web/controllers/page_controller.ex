defmodule IntroProjectWeb.PageController do
  use IntroProjectWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
