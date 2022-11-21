defmodule GraphqlApi.Accounts do

  alias GraphqlApi.Accounts.User
  alias EctoShorts.Actions

  require Logger

  def list_users(params \\ %{}) do
    Actions.all(User, params)
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

end