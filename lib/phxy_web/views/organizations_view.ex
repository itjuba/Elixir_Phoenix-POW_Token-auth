defmodule PhxyWeb.OrganizationsView do
  use PhxyWeb, :view
  alias PhxyWeb.OrganizationsView

  def render("index.json", %{organizations: organizations}) do
    %{data: render_many(organizations, OrganizationsView, "organizations.json")}
  end

  def render("show.json", %{organizations: organizations}) do
    %{data: render_one(organizations, OrganizationsView, "organizations.json")}
  end

  def render("organizations.json", %{organizations: organizations}) do
    %{id: organizations.id,
      name: organizations.name}
  end
end
