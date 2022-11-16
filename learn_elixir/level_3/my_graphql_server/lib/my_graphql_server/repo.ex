defmodule MyGraphqlServer.Repo do
  use Ecto.Repo,
    otp_app: :my_graphql_server,
    adapter: Ecto.Adapters.Postgres
end
