defmodule GraphqlApiWeb.Resolver.User do
  alias GraphqlApiWeb.User

  require Logger

  def find_by_id(%{id: id}, _) do
    id = String.to_integer(id)
    User.find_by_id(%{id: id})
  end

  def filter_by_preferences(params, _), do: User.find_by_preferences(params)
end
