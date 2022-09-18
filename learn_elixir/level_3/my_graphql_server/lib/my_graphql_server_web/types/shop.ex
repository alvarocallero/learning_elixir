defmodule MyGraphqlServerWeb.Types.Shop do
  use Absinthe.Schema.Notation

  @desc "A category for a shop"
  enum :shop_category do
    value :HARDWARE
    value :CLOTHING
  end

  object :shop_address do
    field :country, :string
    field :city, :string
  end

  @desc "A store that has a category"
  object :shop do
    field :id, :id
    field :name, :string
    field :category, :shop_category

    field :address, :shop_address
  end
end