defmodule PhxyWeb.OrganizationsControllerTest do
  use PhxyWeb.ConnCase

  alias Phxy.Organizations_context
  alias Phxy.Organizations_context.Organizations

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:organizations) do
    {:ok, organizations} = Organizations_context.create_organizations(@create_attrs)
    organizations
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all organizations", %{conn: conn} do
      conn = get(conn, Routes.organizations_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create organizations" do
    test "renders organizations when data is valid", %{conn: conn} do
      conn = post(conn, Routes.organizations_path(conn, :create), organizations: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.organizations_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.organizations_path(conn, :create), organizations: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update organizations" do
    setup [:create_organizations]

    test "renders organizations when data is valid", %{conn: conn, organizations: %Organizations{id: id} = organizations} do
      conn = put(conn, Routes.organizations_path(conn, :update, organizations), organizations: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.organizations_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, organizations: organizations} do
      conn = put(conn, Routes.organizations_path(conn, :update, organizations), organizations: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete organizations" do
    setup [:create_organizations]

    test "deletes chosen organizations", %{conn: conn, organizations: organizations} do
      conn = delete(conn, Routes.organizations_path(conn, :delete, organizations))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.organizations_path(conn, :show, organizations))
      end
    end
  end

  defp create_organizations(_) do
    organizations = fixture(:organizations)
    %{organizations: organizations}
  end
end
