defmodule Phxy.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    field :name, :string
    field :username, :string
    field :address, :string
    pow_user_fields()
    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:name, :address, :username])
  #  |> Ecto.Changeset.validate_required([:custom])
  end
end
