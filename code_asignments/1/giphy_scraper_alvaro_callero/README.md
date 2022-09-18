# GiphyScraper AlvaroCallero

This is a simple Elixir app that scraps gifs from the Giphy API

## Usage
In order to scrap gifs from Giphy just execute this comands:
1. mix deps.get
2. iex -S mix
3. GiphyScraper.search(query) where _query_ is a String

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `giphy_scraper_alvaro_callero` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:giphy_scraper_alvaro_callero, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/giphy_scraper_alvaro_callero>.

