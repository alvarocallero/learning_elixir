defmodule OverviewProject.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      OverviewProject.Repo,
      # Start the Telemetry supervisor
      OverviewProjectWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OverviewProject.PubSub},
      # Start the Endpoint (http/https)
      OverviewProjectWeb.Endpoint
      # Start a worker by calling: OverviewProject.Worker.start_link(arg)
      # {OverviewProject.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OverviewProject.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OverviewProjectWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
