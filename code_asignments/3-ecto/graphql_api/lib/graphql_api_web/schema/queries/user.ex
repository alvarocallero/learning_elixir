defmodule GraphqlApiWeb.Schema.Queries.User do
  use Absinthe.Schema.Notation

  alias GraphqlApiWeb.Resolver

  object :user_queries do
    @desc "Get a user filtering by the id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolver.User.find_by_id/2)
    end

    @desc "Get a list of users filtering by likes_emails, likes_phone_calls or likes_faxes"
    field :users, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      arg(:first, :integer)
      arg(:before, :integer)
      arg(:after, :integer)
      resolve(&Resolver.User.filter_by_preferences/2)
    end
  end
end
