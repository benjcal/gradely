defmodule Gradely.Users do
  import Ecto.Query, warn: false
  alias Gradely.Repo

  alias Gradely.Users.User
  alias Gradely.Users.Preferences

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def update_preferences(user, preferences) do
    user
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_embed(:preferences, preferences)
    |> Gradely.Repo.update!
  end

  def is_admin(user) do
    user.type == 0
  end

end
