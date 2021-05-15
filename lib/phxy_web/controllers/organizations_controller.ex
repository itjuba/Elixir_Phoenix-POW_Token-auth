defmodule PhxyWeb.OrganizationsController do
  use PhxyWeb, :controller

  alias Phxy.Organizations_context
  alias Phxy.Organizations_context.Organizations

  action_fallback PhxyWeb.FallbackController

  def index(conn, _params) do
    organizations = Organizations_context.list_organizations()
    render(conn, "index.json", organizations: organizations)
  end

  def create(conn, %{"organizations" => organizations_params}) do
    with {:ok, %Organizations{} = organizations} <- Organizations_context.create_organizations(organizations_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.organizations_path(conn, :show, organizations))
      |> render("show.json", organizations: organizations)
    end
  end

  def show(conn, %{"id" => id}) do
    organizations = Organizations_context.get_organizations!(id)
    render(conn, "show.json", organizations: organizations)
  end

  def update(conn, %{"id" => id, "organizations" => organizations_params}) do
    organizations = Organizations_context.get_organizations!(id)

    with {:ok, %Organizations{} = organizations} <- Organizations_context.update_organizations(organizations, organizations_params) do
      render(conn, "show.json", organizations: organizations)
    end
  end

  def delete(conn, %{"id" => id}) do
    organizations = Organizations_context.get_organizations!(id)

    with {:ok, %Organizations{}} <- Organizations_context.delete_organizations(organizations) do
      send_resp(conn, :no_content, "")
    end
  end
end
