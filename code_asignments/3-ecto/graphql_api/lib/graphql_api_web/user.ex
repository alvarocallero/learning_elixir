defmodule GraphqlApiWeb.User do
  @moduledoc """
    This module will contain the data about the users and the functions to retrieve those data.
  """
  require Logger

  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true,
        likes_faxes: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false,
        likes_faxes: true
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true,
        likes_faxes: false
      }
    },
    %{
      id: 4,
      name: "Tim",
      email: "tim@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false,
        likes_faxes: false
      }
    }
  ]

  def create(id, params) do
    case find_by_id(%{id: id}) do
      {:ok, _user} -> {:error, %{message: "user already exists", details: %{id: id}}}
      _ -> {:ok, params}
    end
  end

  def update_preferences(id, params) do
    with {:ok, user} <- find_by_id(%{id: id}),
         {:ok, _} <- empty_preferences?(params.preferences) do
      {:ok, %{user | preferences: params.preferences}}
    else
      error -> error
    end
  end

  def update_user(id, params) do
    with {:ok, user} <- find_by_id(%{id: id}) do
      {:ok, Map.merge(user, params)}
    end
  end

  def find_by_id(%{id: id}) do
    case Enum.find(@users, &(&1.id === id)) do
      nil -> {:error, %{message: "not found", details: %{id: id}}}
      user -> {:ok, user}
    end
  end

  @doc """
  This function will filter by the user preferences (likes_emails, likes_faxes, and likes_phone_calls).
  """
  def find_by_preferences(%{} = user_preferences) do
    case Enum.filter(@users, &(Map.take(&1.preferences, Map.keys(user_preferences)) === user_preferences)) do
      [] -> {:error, %{message: "not found", details: %{preferences: user_preferences}}}
      users -> {:ok, users}
    end
  end

  defp empty_preferences?(preferences) when preferences === %{},
       do: {:error, %{message: "at least one preference must be provided", details: preferences}}

  defp empty_preferences?(_preferences), do: {:ok, ""}
end