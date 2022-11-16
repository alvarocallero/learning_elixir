defmodule MyGraphqlServer.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :text
      add :category, :text
      add :address_id, references(:addresses, on_delete: :delete_all)

    end

    create index(:shops, [:address_id])
  end
end
