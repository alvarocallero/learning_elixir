defmodule GraphqlApiWeb.Types.User do
  use Absinthe.Schema.Notation

  @desc "Information about the platform clients"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:preferences, :user_preferences)
  end

  @desc "The preferences that each user has"
  object :user_preferences do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
