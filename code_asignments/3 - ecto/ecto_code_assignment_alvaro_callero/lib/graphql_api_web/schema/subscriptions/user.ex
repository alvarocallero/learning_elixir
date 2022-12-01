defmodule GraphqlApiWeb.Schema.Subscriptions.User do
  use Absinthe.Schema.Notation

  require Logger

  object :user_subscriptions do
    @desc "Get a notification whenever a new user is created"
    field :created_user, :user do
      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)

      trigger(:create_user,
        topic: fn _ ->
          "new_user"
        end
      )
    end

    @desc "Get a notification whenever a user preference gets updated"
    field :updated_user_preferences, :user_preferences do
      arg :id, non_null :id

      config(fn args, _ ->
        {:ok, topic: args.id}
      end)

      trigger(:update_user_preferences,
        topic: fn _ ->
          "user_updated"
        end
      )
    end
  end
end
