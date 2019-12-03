defmodule Gradely.Repo.Migrations.CreateCourseUser do
  use Ecto.Migration

  def change do
    create table(:course_user) do
      add :course_id, references(:courses), null: false
      add :user_id, references(:users), null: false
    end

  end
end
