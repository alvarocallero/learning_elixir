defmodule EctoExample.Properties.Address do
  use Ecto.Schema

  schema "addresses" do
    field :country, :string

    has_many :houses, EctoExample.Properties.House
  end
end
