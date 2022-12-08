defmodule GraphqlApi.Accounts do
  alias EctoShorts.Actions
  alias GraphqlApi.{Repo, Accounts.User, Accounts.Preference}
  import Ecto.Query

  require Logger

  def list_users(params) do
    IO.inspect params
    params
    |> create_query_with_preferences_filters()
    |> get_all_users(params)
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def get_user_with_preferences(%{id: id}) do
    repo_result = Repo.one(from(u in User, where: u.id == ^id))
    user = Repo.preload(repo_result, :preference)
    {:ok, user}
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_preferences(user, preferences) do
    Preference
    |> Repo.get(user.preference.id)
    |> Preference.changeset(preferences)
    |> Repo.update!()

    {:ok, user}
  end

  defp create_query_with_preferences_filters(params) do
    Enum.reduce(params, User.join_preference(), &convert_field_to_query/2)
  end

  defp get_all_users(query, params) do
    Actions.all(query, params)
  end

  defp convert_field_to_query({:likes_emails, value}, query) do
    User.by_likes_emails(query, value)
  end

  defp convert_field_to_query({:likes_faxes, value}, query) do
    User.by_likes_faxes(query, value)
  end

  defp convert_field_to_query({:likes_phone_calls, value}, query) do
    User.by_likes_phone_calls(query, value)
  end

  defp convert_field_to_query(_, query) do
    query
  end
end
