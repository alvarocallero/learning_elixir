defmodule RestServerWeb.UserControllerTest do
  use RestServerWeb.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get(conn, "/users")
    assert %{"data" => users} = Jason.decode!(conn.resp_body)
    assert length(users) === 3
  end

  test "DELETE /users/:id", %{conn: conn} do
    conn = delete(conn, "/users/1")
    assert %{"data" => users} = Jason.decode!(conn.resp_body)
    refute Enum.find(users, &(&1["id"] === 1))
  end


end
