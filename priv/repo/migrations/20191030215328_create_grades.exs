defmodule Gradely.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades) do
      add :user_id, references(:users), null: false
      timestamps()
    end

  end
end
