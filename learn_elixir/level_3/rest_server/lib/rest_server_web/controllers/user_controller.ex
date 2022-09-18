defmodule RestServerWeb.UserController do
  use RestServerWeb, :controller

  @users [
    %{
      id: 1,
      name: "bob"
    },
    %{
      id: 2,
      name: "alice"
    },
    %{
      id: 3,
      name: "joe"
    }
  ]

  def index(conn, _params) do
    IO.puts "se ejecuta el index"
    render(conn, "index.json", users: @users)
  end

  def show(conn, %{"id" => id}) do
    IO.puts "se ejecuta el show"
    user = Enum.find(@users, &user_by_id(&1, id))
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "name" => name}) do
    user = Enum.find(@users, &user_by_id(&1, id))
    render(conn, "show.json", user: %{user | name: name})
  end

  def create(conn, %{"name" => name}) do
    user = %{id: 4, name: name}
    render(conn, "show.json", user: user)
  end

  def delete(conn, %{"id" => id}) do
    users = Enum.reject(@users, &user_by_id(&1, id))
    render(conn, "index.json", users: users)

  end

  defp user_by_id(%{id: id}, string_id) do
    id === String.to_integer(string_id)
  end
end
