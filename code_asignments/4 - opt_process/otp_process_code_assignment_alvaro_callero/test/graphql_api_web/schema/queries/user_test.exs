defmodule GraphqlApiWeb.Schema.Queries.UserTest do
  use GraphqlApiWeb.DataCase

  alias GraphqlApiWeb.Schema
  alias GraphqlApi.Accounts
  alias GraphqlApi.RequestsManager

  @get_all_users_doc """
  query AllUsers {
    users{
        id
        email
        name
        preference{
          likesEmails
          likesFaxes
          likesPhoneCalls
        }
      }
    }
  """

  @get_one_user_doc """
  query OneUser($id: ID!) {
    user(id: $id){
        id
        email
        name
        preference{
          likesEmails
          likesFaxes
          likesPhoneCalls
        }
      }
    }
  """

  @get_request_hits_counter """
  query GetRequestHits($key: String!) {
    resolver_hits(key: $key)
    }
  """

  @test_user %{
    name: "Peter Parker",
    email: "peter@parker.com.uy",
    preference: %{
      likesEmails: true,
      likesFaxes: true,
      likesPhoneCalls: true
    }
  }

  describe "@users" do
    test "fetches all users" do
      assert {:ok, %{data: old_data}} = Absinthe.run(@get_all_users_doc, Schema)

      assert {:ok, user} =
               Accounts.create_user(@test_user)

      assert {:ok, %{data: new_data}} = Absinthe.run(@get_all_users_doc, Schema)
      assert length(old_data["users"]) + 1 == length(new_data["users"])

      search_result =
        new_data["users"]
        |> Enum.filter(&(&1["name"] === user.name))
        |> length != 0

      assert search_result == true
    end
  end

  describe "@user" do
    test "fetch a specific user" do
      assert {:ok, user} =
               Accounts.create_user(@test_user)

      assert {:ok, %{data: data}} =
               Absinthe.run(@get_one_user_doc, Schema,
                 variables: %{
                   "id" => user.id
                 }
               )

      assert data["user"]["name"] === user.name
      assert data["user"]["id"] === to_string(user.id)
      assert data["user"]["email"] === user.email
    end
  end

  describe "@resolver_hits" do
    test "get the hits count of the request get all users query" do

      assert {:ok, %{data: data}} =
               Absinthe.run(@get_request_hits_counter, Schema,
                 variables: %{
                   "key" => "users"
                 }
               )
      initial_hits_counter = data["resolver_hits"]

      assert {:ok, %{data: get_users_data}} = Absinthe.run(@get_all_users_doc, Schema)

      assert {:ok, %{data: new_data}} =
               Absinthe.run(@get_request_hits_counter, Schema,
                 variables: %{
                   "key" => "users"
                 }
               )

      final_hits_counter = new_data["resolver_hits"]

      assert initial_hits_counter + 1 === final_hits_counter
    end
  end
end
