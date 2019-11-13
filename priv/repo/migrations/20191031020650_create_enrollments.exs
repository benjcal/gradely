defmodule Gradely.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :student_id, references(:students, on_delete: :delete_all)

      timestamps()
    end

    create index(:enrollments, [:course_id])
    create index(:enrollments, [:student_id])
  end
end
