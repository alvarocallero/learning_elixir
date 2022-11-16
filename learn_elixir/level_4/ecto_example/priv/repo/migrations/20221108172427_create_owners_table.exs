defmodule EctoExample.Repo.Migrations.CreateOwnersTable do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :name, :text
    end
  end
end
