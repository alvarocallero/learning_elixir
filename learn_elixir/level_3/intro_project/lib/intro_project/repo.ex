defmodule IntroProject.Repo do
  use Ecto.Repo,
    otp_app: :intro_project,
    adapter: Ecto.Adapters.Postgres
end
