defmodule GraphqlApiWeb.Schema.Mutations.UserTest do
  use GraphqlApiWeb.DataCase, async: true

  alias GraphqlApiWeb.Schema
  alias GraphqlApi.Accounts
  alias GraphqlApiWeb.UserHelper

  @create_user_doc """
  mutation CreateUser($name: String!, $email: String!, $preference: InputUserPreferences!) {
    create_user(name: $name, email: $email, preference: $preference){
      #{UserHelper.get_fields_to_fetch_from_user()}
      }
    }
  """

  @update_user_doc """
  mutation UpdateUser($id: ID!, $name: String!, $email: String!) {
    update_user(id: $id, name: $name, email: $email){
      #{UserHelper.get_fields_to_fetch_from_user()}
      }
    }
  """

  @update_user_preferences_doc """
  mutation UpdateUserPreferences($id: ID!, $preferences: InputUserPreferences!) {
    update_user_preferences(id: $id, preferences: $preferences){
      #{UserHelper.get_fields_to_fetch_from_user()}
      }
    }
  """

  describe "@update_user" do
    test "update a user by id" do
      assert {:ok, user} = Accounts.create_user(UserHelper.get_user())

      assert {:ok, %{data: data}} =
               Absinthe.run(@update_user_doc, Schema,
                 variables: %{
                   "id" => user.id,
                   "name" => "Marcelo Zalayeta",
                   "email" => "mzalayeta@adinet.com.uy"
                 }
               )

      assert data["update_user"]["name"] === "Marcelo Zalayeta"
      assert data["update_user"]["email"] === "mzalayeta@adinet.com.uy"
    end
  end

  describe "@create_user" do
    test "create a user" do
      assert {:ok, %{data: data}} =
               Absinthe.run(@create_user_doc, Schema, variables: UserHelper.get_user())

      assert data["create_user"]["name"] === "Peter Parker"
      assert data["create_user"]["email"] === "peter@parker.com.uy"
      assert data["create_user"]["preference"]["likesEmails"] === true
      assert data["create_user"]["preference"]["likesFaxes"] === false
      assert data["create_user"]["preference"]["likesPhoneCalls"] === true

      assert {:ok, user} = Accounts.find_user(%{id: data["create_user"]["id"]})
      assert user.name === "Peter Parker"
      assert user.email === "peter@parker.com.uy"
    end
  end

  describe "@update_user_preferences" do
    test "update the preferences of a user by id" do
      assert {:ok, user} = Accounts.create_user(UserHelper.get_user())

      assert {:ok, %{data: data}} =
               Absinthe.run(@update_user_preferences_doc, Schema,
                 variables: %{
                   "id" => user.id,
                   "preferences" => %{
                     "likesEmails" => false,
                     "likesFaxes" => true,
                     "likesPhoneCalls" => false
                   }
                 }
               )

      assert data["update_user_preferences"]["preference"]["likesEmails"] === false
      assert data["update_user_preferences"]["preference"]["likesFaxes"] === true
      assert data["update_user_preferences"]["preference"]["likesPhoneCalls"] === false
    end
  end
end
