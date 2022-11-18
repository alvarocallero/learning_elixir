defmodule GraphqlApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :preference_id, references(:preferences, on_delete: :nothing)
    end

    create index(:users, [:preference_id])
  end
end
