defmodule GraphqlApiWeb.Resolver.User do
  alias GraphqlApi.Accounts

  require Logger

  def find_by_id(%{id: id}, _) do
    id = String.to_integer(id)

    %{id: id}
    |> Accounts.find_user()
    |> build_response
  end

  def filter_by_preferences(params, _) do
    users = Accounts.list_users(params)
    {:ok, users}
  end

  def update(%{id: id} = params, _) do
    id = String.to_integer(id)
    params = Map.delete(params, :id)
    Accounts.update_user(id, params)
  end

  def create(params, _) do
    Accounts.create_user(params)
  end

  def update_preferences(%{id: id} = params, _) do
    with {:ok, _} <- empty_preferences?(params.preferences),
         {:ok, user} <- Accounts.get_user_with_preferences(%{id: id}) do
      Accounts.update_preferences(user, params.preferences)
    else
      {:error, _} -> {:error, %{message: "not found", details: "not found"}}
    end
  end

  def build_response(result) do
    if elem(result, 0) === :error do
      {:error, %{message: "not found", details: "not found"}}
    else
      result
    end
  end

  defp empty_preferences?(preferences) when preferences === %{},
    do: {:error, %{message: "at least one preference must be provided", details: preferences}}

  defp empty_preferences?(_preferences), do: {:ok, " "}
end
