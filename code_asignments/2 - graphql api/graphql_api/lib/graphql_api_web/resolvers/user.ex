defmodule GraphqlApiWeb.Resolver.User do
  alias GraphqlApiWeb.User

  require Logger

  def find_by_id(%{id: id}, _) do
    id = String.to_integer(id)
    User.find_by_id(%{id: id})
  end

  def filter_by_preferences(params, _), do: User.find_by_preferences(params)

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.update_user(id, Map.delete(params, :id))
  end

  def create(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.create(id, params)
  end

  def update_preferences(%{id: id} = params, _) do
    id = String.to_integer(id)
    User.update_preferences(id, params)
  end
end
