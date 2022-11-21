defmodule GraphqlApiWeb.Resolver.User do
  alias GraphqlApi.Accounts

  require Logger

  def find_by_id(%{id: id}, _) do
    id = String.to_integer(id)
    %{id: id}
    |> Accounts.find_user()
  end

  def filter_by_preferences(params, _) do
    users =
    %{preferences: params}
    |> Accounts.list_users()
    {:ok, users}
  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)
    params = params
    |> Map.delete(:id)

    id
    |> Accounts.update_user(params)
  end

  def create(params, _) do
    Accounts.create_user(params)
  end
#
#  def update_preferences(%{id: id} = params, _) do
#    id = String.to_integer(id)
#    User.update_preferences(id, params)
#  end



end
