defmodule EctoExample.Repo.Migrations.CreateOwnersHousesTable do
  use Ecto.Migration

  def change do
    create table(:owners_houses, primary_key: false) do
      add :owner_id, references(:owners, on_delete: :delete_all)
      add :house_id, references(:houses, on_delete: :delete_all)
    end

    create index(:owners_houses, :house_id)
    create index(:owners_houses, :owner_id)
  end
end
