defmodule EctoExample.Repo.Migrations.CreateAddressTable do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :country, :text
    end
  end
end
