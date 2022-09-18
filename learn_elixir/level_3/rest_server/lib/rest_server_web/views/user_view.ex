defmodule RestServerWeb.UserView do
  use RestServerWeb, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, RestServerWeb.UserView, "user.json")}
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, RestServerWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
    id: user.id,
    name: user.name
    }
  end

end
