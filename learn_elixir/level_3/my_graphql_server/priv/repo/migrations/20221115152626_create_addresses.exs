defmodule MyGraphqlServer.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :city, :text
      add :country, :text
    end
  end
end
