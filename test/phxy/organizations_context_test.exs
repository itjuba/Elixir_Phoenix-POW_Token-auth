defmodule Phxy.Organizations_contextTest do
  use Phxy.DataCase

  alias Phxy.Organizations_context

  describe "organizations" do
    alias Phxy.Organizations_context.Organizations

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def organizations_fixture(attrs \\ %{}) do
      {:ok, organizations} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organizations_context.create_organizations()

      organizations
    end

    test "list_organizations/0 returns all organizations" do
      organizations = organizations_fixture()
      assert Organizations_context.list_organizations() == [organizations]
    end

    test "get_organizations!/1 returns the organizations with given id" do
      organizations = organizations_fixture()
      assert Organizations_context.get_organizations!(organizations.id) == organizations
    end

    test "create_organizations/1 with valid data creates a organizations" do
      assert {:ok, %Organizations{} = organizations} = Organizations_context.create_organizations(@valid_attrs)
      assert organizations.name == "some name"
    end

    test "create_organizations/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations_context.create_organizations(@invalid_attrs)
    end

    test "update_organizations/2 with valid data updates the organizations" do
      organizations = organizations_fixture()
      assert {:ok, %Organizations{} = organizations} = Organizations_context.update_organizations(organizations, @update_attrs)
      assert organizations.name == "some updated name"
    end

    test "update_organizations/2 with invalid data returns error changeset" do
      organizations = organizations_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations_context.update_organizations(organizations, @invalid_attrs)
      assert organizations == Organizations_context.get_organizations!(organizations.id)
    end

    test "delete_organizations/1 deletes the organizations" do
      organizations = organizations_fixture()
      assert {:ok, %Organizations{}} = Organizations_context.delete_organizations(organizations)
      assert_raise Ecto.NoResultsError, fn -> Organizations_context.get_organizations!(organizations.id) end
    end

    test "change_organizations/1 returns a organizations changeset" do
      organizations = organizations_fixture()
      assert %Ecto.Changeset{} = Organizations_context.change_organizations(organizations)
    end
  end
end
