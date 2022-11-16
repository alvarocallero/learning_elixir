defmodule MyGraphqlServer.Retail.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :category, :string
    field :name, :string
    belongs_to :address, MyGraphqlServer.Retail.Address
  end

  @available_fields [:name, :category]

  def create_changeset(params) do
    changeset(%MyGraphqlServer.Retail.Shop{}, params)
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, @available_fields)
    |> validate_required(@available_fields)
    |> cast_assoc(:address)
  end
end
