defmodule Gradely.Repo.Migrations.CreateActivityType do
  use Ecto.Migration

  def change do
    create table(:activity_type) do
      add :name, :string

      timestamps()
    end
  end
end
