import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_graphql_server, MyGraphqlServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/uFZTrTrFwXpWpHH5PE/HFRbIizS5ZOkzWChU04tH9Vo8y5/HWmiEyx2KXlljUQY",
  server: false

# In test we don't send emails.
config :my_graphql_server, MyGraphqlServer.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
