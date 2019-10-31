defmodule Gradely.Enrollments do
  @moduledoc """
  The Enrollments context.
  """

  import Ecto.Query, warn: false
  alias Gradely.Repo

  def enroll_student(student, courses) do
    student
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:courses, courses)
    |> Repo.update!
  end
end
