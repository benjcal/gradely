defmodule Gradely.Repo.Migrations.CreateCourseStudent do
  use Ecto.Migration

  def change do
    create table(:course_student, primary_key: false) do
      add :course_id, references(:courses), null: false
      add :student_id, references(:students), null: false


      timestamps()
    end

    create unique_index(:course_student, [:course_id, :student_id])

  end
end
