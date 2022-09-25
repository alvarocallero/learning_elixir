defmodule GiphyScraperAlvaroCallero.MixProject do
  use Mix.Project

  def project do
    [
      app: :giphy_scraper_alvaro_callero,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {GiphyScraperAlvaroCallero.Application, []}
    ]
  end

  defp deps do
    [
      {:finch, "~> 0.13"},
      {:jason, "~> 1.3"}
    ]
  end
end
