defmodule EctoTest.Retail.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string
    belongs_to :address, EctoTest.Retail.Address
  end

  @available_field [:name]

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, @available_field)
    |> validate_required(@available_field)
    |> cast_assoc(:address) #when we create an address then we create a shop also

  end
end

Elena 098 858 592