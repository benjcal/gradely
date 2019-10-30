defmodule Gradely.Repo.Migrations.CreateCoursesStudents do
  use Ecto.Migration

  def change do
    create table(:courses_students) do
      add :course_id, references(:courses)
      add :student_id, references(:students)
      timestamps()
    end

  end
end
