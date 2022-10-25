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
  The logic that this function follows is the following:
  filter by likes_emails?
    no -> filter by likes_faxes?
            no ->  filter by likes_phone_calls?
                    no -> all users are returned since no filtering fields were provided
                    yes -> filter only by likes_phone_calls
    yes -> filter by likes_faxes?
    ...
  """
  def find_by_preferences(%{} = params) do
    case Map.has_key?(params, :likes_emails) do
      false ->
        case Map.has_key?(params, :likes_faxes) do
          false ->
            case Map.has_key?(params, :likes_phone_calls) do
              false -> {:ok, @users}
              _ -> find_by_likes_phone_calls(params)
            end

          true ->
            case Map.has_key?(params, :likes_phone_calls) do
              false -> find_by_likes_faxes(params)
              _ -> find_by_likes_phone_calls_and_likes_faxes(params)
            end
        end

      _ ->
        case Map.has_key?(params, :likes_faxes) do
          false ->
            case Map.has_key?(params, :likes_phone_calls) do
              false -> find_by_likes_emails(params)
              _ -> find_by_likes_emails_and_likes_phone_calls(params)
            end

          _ ->
            case Map.has_key?(params, :likes_phone_calls) do
              false -> find_by_likes_emails_and_likes_faxes(params)
              _ -> filter_by_all_preferences(params)
            end
        end
    end
  end

  defp find_by_likes_phone_calls(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_phone_calls === Map.get(params, :likes_phone_calls))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp find_by_likes_emails(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_emails === Map.get(params, :likes_emails))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp find_by_likes_faxes(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_faxes === Map.get(params, :likes_faxes))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp find_by_likes_emails_and_likes_phone_calls(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_emails === Map.get(params, :likes_emails) &&
               &1.preferences.likes_phone_calls === Map.get(params, :likes_phone_calls))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp find_by_likes_emails_and_likes_faxes(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_emails === Map.get(params, :likes_emails) &&
               &1.preferences.likes_faxes === Map.get(params, :likes_faxes))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp find_by_likes_phone_calls_and_likes_faxes(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_phone_calls === Map.get(params, :likes_phone_calls) &&
               &1.preferences.likes_faxes === Map.get(params, :likes_faxes))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp filter_by_all_preferences(params) do
    case Enum.filter(
           @users,
           &(&1.preferences.likes_phone_calls === Map.get(params, :likes_phone_calls) &&
               &1.preferences.likes_faxes === Map.get(params, :likes_faxes) &&
               &1.preferences.likes_emails === Map.get(params, :likes_emails))
         ) do
      [] -> {:error, %{message: "not found", details: params}}
      users -> {:ok, users}
    end
  end

  defp empty_preferences?(preferences) when preferences === %{},
    do: {:error, %{message: "at least one preference must be provided", details: preferences}}

  defp empty_preferences?(_preferences), do: {:ok, ""}
end
