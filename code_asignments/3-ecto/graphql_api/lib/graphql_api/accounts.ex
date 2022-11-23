defmodule GraphqlApi.Accounts do

  alias EctoShorts.Actions
  alias GraphqlApi.{Repo, Accounts.User}

  require Logger
  def list_users(params) do
    params
    |> Enum.reduce(User.join_preference(), &convert_field_to_query/2)
    |> Repo.all
  end

  def convert_field_to_query({:likes_emails, value}, query) do
    User.by_likes_emails(query, value)
  end

  def convert_field_to_query({:likes_faxes, value}, query) do
    User.by_likes_faxes(query, value)
  end

  def convert_field_to_query({:likes_phone_calls, value}, query) do
    User.by_likes_phone_calls(query, value)
  end



  def find_user(params) do
    Actions.find(User, params)
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def create_user(params) do
    Actions.create(Accounts.User, params)
  end

end