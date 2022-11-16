import Config

config :ecto_example, EctoExample.Repo,
  database: "ecto_example_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :ecto_example,
       ecto_repos: [EctoExample.Repo]
