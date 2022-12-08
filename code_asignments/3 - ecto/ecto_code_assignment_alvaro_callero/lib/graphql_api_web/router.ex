defmodule GraphqlApiWeb.Router do
  use GraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api
  end

  forward "/graphql", Absinthe.Plug, schema: GraphqlApiWeb.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: GraphqlApiWeb.Schema,
    socket: GraphqlApiWeb.UserSocket,
    interface: :playground
end
