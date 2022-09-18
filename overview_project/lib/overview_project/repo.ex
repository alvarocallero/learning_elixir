defmodule OverviewProject.Repo do
  use Ecto.Repo,
    otp_app: :overview_project,
    adapter: Ecto.Adapters.Postgres
end
