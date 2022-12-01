import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :graphql_api, GraphqlApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RyikdmZHyy4BrgqHoRb72+2uwRSXGBAiJgRt1y/2RWU0m38Vd3Xn5M8Ql6w1jv6P",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
