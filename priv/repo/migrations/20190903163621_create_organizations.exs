defmodule Gradely.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string

      add :settings, :map, on_replace: :delete

      timestamps()
    end

  end
end
