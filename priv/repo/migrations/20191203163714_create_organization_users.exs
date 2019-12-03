defmodule Gradely.Repo.Migrations.OrganizationUsers do
  use Ecto.Migration

  def change do
    create table(:organization_users, primary_key: false) do
      add :organization_id, references(:organizations, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:organization_users, [:organization_id, :user_id])

  end
end
