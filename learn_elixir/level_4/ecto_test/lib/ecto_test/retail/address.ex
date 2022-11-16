defmodule EctoTest.Retail.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :city, :string
  end

  @available_fields [:city]

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
  end
end
