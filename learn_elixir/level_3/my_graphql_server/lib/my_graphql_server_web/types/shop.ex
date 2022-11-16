defmodule MyGraphqlServerWeb.Types.Shop do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  @desc "A category for a shop"
  enum :shop_category do
    value :HARDWARE
    value :CLOTHING
  end

  object :shop_address do
    field :id, :id
    field :country, :string
    field :city, :string
  end

  input_object :shop_address_input do
    field :country, non_null(:string)
    field :city, non_null(:string)
  end


  @desc "A store that has a category"
  object :shop do
    field :id, :id
    field :name, :string
    field :category, :shop_category

    field :address, :shop_address, resolve: dataloader(MyGraphqlServer.Retail, :address)
  end
end