import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :intro_project, IntroProject.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "intro_project_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :intro_project, IntroProjectWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "UK5S8YpDP9ekIqwT9o2CJJv+Ams7ilPsTXFD4ZwKC2XaX1TJUDibp+A7lCkNDG+p",
  server: false

# In test we don't send emails.
config :intro_project, IntroProject.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
