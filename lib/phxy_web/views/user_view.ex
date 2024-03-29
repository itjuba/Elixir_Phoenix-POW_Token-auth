defmodule PhxyWeb.UserView do
  use PhxyWeb, :view
  alias PhxyWeb.UserView

  def render("index.json", %{user: user}) do
    %{data: render_many(user, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      name: user.name,
      email: user.email,
      password: user.password}
  end
end
