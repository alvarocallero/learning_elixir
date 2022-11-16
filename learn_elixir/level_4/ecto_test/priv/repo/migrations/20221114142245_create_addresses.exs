defmodule EctoTest.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :city, :string
    end
  end
end
