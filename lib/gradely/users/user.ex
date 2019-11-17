defmodule Gradely.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    embeds_one :preferences, Gradely.Users.Preferences

    timestamps()
  end
end

defmodule Gradely.Users.Preferences do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :sample, :string
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:sample])
    |> validate_required([:sample])
  end
end