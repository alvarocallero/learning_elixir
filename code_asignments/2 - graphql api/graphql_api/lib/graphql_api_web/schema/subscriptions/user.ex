defmodule GraphqlApiWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  alias GraphqlApiWeb.Resolver

  require Logger

  object :user_subscriptions do
    @desc "Get a notification whenever a new user is created"
    field :user_created, :user do

      config fn _, _ ->
        {:ok, topic: "new_user"}
      end

      trigger :create_user, topic: fn _ ->
        "new_user"
      end
    end
  end
end
