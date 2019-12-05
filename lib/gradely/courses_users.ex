defmodule Gradely.CoursesUsers do
  @moduledoc """
  The Enrollments context.
  """

  import Ecto.Query, warn: false
  alias Gradely.Repo

  def add_user_to_course(user, course) do
    course
    |> Repo.preload(:users)
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:users, [user])
    |> Repo.update!
  end
end
