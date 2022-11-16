defmodule EctoTest.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string
      add :address_id, references(:addresses, on_delete: :delete_all)
      #when an address is deleted, all the related shops are deleted
    end

    create index(:shops, [:address_id])
  end
end
