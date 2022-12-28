defmodule GraphqlApiWeb.UserHelper do
  @test_user %{
    "name" => "Peter Parker",
    "email" => "peter@parker.com.uy",
    "preference" => %{
      "likesEmails" => true,
      "likesFaxes" => false,
      "likesPhoneCalls" => true
    }
  }

  @fields_to_fetch_from_user "
        id
        email
        name
        preference{
          likesEmails
          likesFaxes
          likesPhoneCalls
        }"

  def get_user, do: @test_user
  def get_fields_to_fetch_from_user, do: @fields_to_fetch_from_user
end
