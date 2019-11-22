defmodule Gradely.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:enrollments, primary_key: false) do
      add :course_id, references(:courses, on_delete: :delete_all)
      add :student_id, references(:students, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:enrollments, [:course_id, :student_id])
  end
end
