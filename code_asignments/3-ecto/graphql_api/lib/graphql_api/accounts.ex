defmodule GraphqlApi.Accounts do
  alias EctoShorts.Actions
  alias GraphqlApi.{Repo, Accounts.User, Accounts.Preference}
  import Ecto.Query

  require Logger

  def list_users(params) do
    ecto_shorts_filters = Enum.reduce(params, %{}, &convert_field_to_map/2)

    cond do
      ecto_shorts_filters === %{} ->
        params
        |> Enum.reduce(User.join_preference(), &convert_field_to_query/2)
        |> Repo.all()

      true ->
        params
        |> Enum.reduce(User.join_preference(), &convert_field_to_query/2)
        |> Actions.all(ecto_shorts_filters)
    end
  end

  def convert_field_to_map({:first, value}, filters) do
    Map.put(filters, :first, value)
  end

  def convert_field_to_map({:before, value}, filters) do
    Map.put(filters, :before, value)
  end

  def convert_field_to_map({:after, value}, filters) do
    Map.put(filters, :after, value)
  end

  def convert_field_to_map(_, filters) do
    filters
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

  def convert_field_to_query(_, query) do
    query
  end

  def find_user(params) do
    Actions.find(User, params)
  end

  def get_user_with_preferences(%{id: id}) do
    user = Repo.one(from(u in User, where: u.id == ^id)) |> Repo.preload(:preference)
    {:ok, user}
  end

  def update_user(id, params) do
    Actions.update(User, id, params)
  end

  def update_preference(id, params) do
    Actions.update(Preference, id, params)
  end

  def create_user(params) do
    Actions.create(User, params)
  end

  def update_preferences(user, preferences) do
    Repo.get(Preference, user.preference.id)
    |> Preference.changeset(preferences)
    |> Repo.update!()

    {:ok, user}
  end
end
