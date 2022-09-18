defmodule GiphyScraperAlvaroCallero.Application do
  @moduledoc """
  Will start a Supervisor with the Finch API as a children"
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Finch, name: FinchAPI}
    ]

    opts = [strategy: :one_for_one, name: GiphyScraperAlvaroCallero.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
