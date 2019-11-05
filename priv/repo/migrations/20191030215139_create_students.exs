defmodule Gradely.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :number, :string
      add :first_name, :string
      add :last_name, :string
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end
