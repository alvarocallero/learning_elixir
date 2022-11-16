defmodule EctoExample.Repo.Migrations.RemoveAddressFromHouses do
  use Ecto.Migration

  def up do
    alter table(:houses) do
      remove :address
    end
  end

  def down do
    alter table(:houses) do
      add :address, :text
    end
  end
end
