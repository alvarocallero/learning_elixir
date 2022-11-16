defmodule EctoExample.Repo.Migrations.AddAddressToHouse do
  use Ecto.Migration

  def change do
    alter table(:houses) do
      add :address_id, references(:addresses, on_delete: :delete_all)
    end
  end
end
