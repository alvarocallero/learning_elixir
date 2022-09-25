defmodule GiphyScraper do
  @moduledoc """
  This module contains the search function to scrap gifs using the Giphy REST API
  """

  defmodule GiphyImage do
    @enforce_keys [:id, :url, :username, :title]
    defstruct [:id, :url, :username, :title]
  end

  @type search_query :: String.t()

  @spec search(search_query) :: list(GiphyImage)
  def search(search_query) do
    "https://api.giphy.com/v1/gifs/search?api_key=c7uNzLZEo1nnEmtoFRHQ2fRQdf66q8dq&q=#{search_query}y&limit=25&offset=0&rating=g&lang=en"
    |> make_http_get_to_giphy_api
    |> parse_giphy_api_response
    |> iterate_list_of_gifs_and_create_struct_for_return
  end

  defp make_http_get_to_giphy_api(url) do
    :get |> Finch.build(url) |> Finch.request(FinchAPI)
  end

  defp parse_giphy_api_response(response) do
    with {:ok, body} <- response do
      body
      |> Map.from_struct()
      |> Map.get(:body)
      |> Jason.decode!()
      |> Map.get("data")
    end
  end

  defp iterate_list_of_gifs_and_create_struct_for_return(list_of_maps) do
    Enum.map(list_of_maps, fn x ->
      %GiphyImage{
        id: Map.get(x, "id"),
        url: Map.get(x, "url"),
        username: Map.get(x, "username"),
        title: Map.get(x, "title")
      }
    end)
  end
end
