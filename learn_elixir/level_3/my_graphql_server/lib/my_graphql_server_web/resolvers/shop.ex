defmodule MyGraphqlServerWeb.Resolvers.Shop do

  alias MyGraphqlServer.Retail

  def all(params, _) do
    shops = params
    |> maybe_serialize_category
    |> Retail.list_shops()

    serialize_category({:ok, shops})
  end

  def find(%{id: id}, _) do
    id = String.to_integer(id)
    %{id: id}
    |> Retail.find_shop()
    |> serialize_category

  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)
    params = params
    |> Map.delete(:id)
    |> maybe_serialize_category

    id
    |> Retail.update_shop(params)
    |> serialize_category

  end

  def create(params, _) do
    params
    |> maybe_serialize_category
    |> Retail.create_shop
    |> serialize_category
  end

  defp maybe_serialize_category(%{category: category} = params) do
    Map.put(params, :category, Atom.to_string(category))
  end

  defp maybe_serialize_category(params) do
    params
  end

  defp serialize_category({:ok, shops}) when is_list(shops) do
    {:ok, Enum.map(shops, fn shop ->
      Map.update!(shop, :category, &String.to_atom/1)
    end)}
  end

  defp serialize_category({:ok, shop}) do
    {:ok, Map.update!(shop, :category, &String.to_atom/1)}
  end

  defp serialize_category(res) do
    res
  end



end