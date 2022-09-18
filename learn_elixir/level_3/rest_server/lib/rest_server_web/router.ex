defmodule RestServerWeb.Router do
  use RestServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RestServerWeb do
    pipe_through :api
    resources "/users", UserController
  end
end
