defmodule GraphqlApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  require Logger

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    belongs_to(:preference, GraphqlApi.Accounts.Preference)
  end

  @available_fields [:name, :email]

  def create_changeset(params) do
    changeset(%GraphqlApi.Accounts.User{}, params)
  end



  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:preference)
  end

  def join_preference(query \\ GraphqlApi.Accounts.User) do
    join(query, :inner, [u], p in assoc(u, :preference), as: :preference)
  end

  def by_likes_emails(query, likes_emails) do
    where(query, [preference: p], p.likes_emails == ^likes_emails)
  end

  def by_likes_faxes(query, likes_faxes) do
    where(query, [preference: p], p.likes_faxes == ^likes_faxes)
  end

  def by_likes_phone_calls(query, phone_calls) do
    where(query, [preference: p], p.likes_phone_calls == ^phone_calls)
  end
end
