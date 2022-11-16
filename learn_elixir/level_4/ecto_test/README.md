# EctoTest

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Make http requests
create a shop with an address
  http post http://localhost:4000/api/shops shop:='{"name" : "Hardware Shop", "address": {"city" : "Vancouver"}}'

get a specific shop
  http get http://localhost:4000/api/shops/1

update a shop
  http put http://localhost:4000/api/shops/1/ shop:='{"name" : "My Clothing Shop"}'

delete a specific shop
  http delete http://localhost:4000/api/shops/1