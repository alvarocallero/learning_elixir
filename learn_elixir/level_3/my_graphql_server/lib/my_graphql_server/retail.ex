defmodule MyGraphqlServer.Retail do

  alias MyGraphqlServer.Retail.Shop
  alias EctoShorts.Actions

  def list_shops(params \\ %{}) do
    Actions.all(Shop, params)
  end

  def find_shop(params) do
    Actions.find(Shop, params)
  end

  def update_shop(id, params) do
    Actions.update(Shop, id, params)
  end

  def create_shop(params) do
    Actions.create(Shop, params)
  end


end