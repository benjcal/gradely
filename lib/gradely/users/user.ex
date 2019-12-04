defmodule Gradely.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    embeds_one :preferences, Gradely.Users.Preferences
    belongs_to :organization, Gradely.Organizations.Organization

    field :type, :integer # 0 = admin, 1 = educator
    timestamps()
  end
end

defmodule Gradely.Users.Preferences do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :student_table_sort, :string
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:student_table_sort])
  end
end
