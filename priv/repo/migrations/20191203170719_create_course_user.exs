defmodule Gradely.Repo.Migrations.CreateCourseUser do
  use Ecto.Migration

  def change do
    create table(:courses_users, primary_key: false) do
      add :course_id, references(:courses), null: false
      add :user_id, references(:users), null: false


      timestamps()
    end

    create unique_index(:courses_users, [:course_id, :user_id])

  end
end
