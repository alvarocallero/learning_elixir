defmodule EctoExample.Repo.Migrations.AddHousesTables do
  use Ecto.Migration

  def change do
    create table(:houses) do
      add :price, :integer, null: false
      add :address, :text
      add :is_occupied, :boolean, default: true
      add :name, :text
    end
  end
end
