defmodule Gradely.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()

    belongs_to :organization, Gradely.Organizations.Organization

    field :type, :integer # 0 = admin, 1 = educator
    timestamps()
  end
end

