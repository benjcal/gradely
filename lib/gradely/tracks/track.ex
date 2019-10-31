defmodule Gradely.Tracks.Track do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracks" do
    field :name, :string
    belongs_to :user, Gradely.Users.User

    timestamps()
  end

  @doc false
  def changeset(track, attrs) do
    track
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end
