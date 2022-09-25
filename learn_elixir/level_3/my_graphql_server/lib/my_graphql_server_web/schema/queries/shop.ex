defmodule MyGraphqlServerWeb.Schema.Queries.Shop do


  alias MyGraphqlServerWeb.Resolvers

  use Absinthe.Schema.Notation

  object :shop_queries do

    field :shop, :shop do
      arg :id, non_null(:id)

      resolve &Resolvers.Shop.find/2
    end

    field :shops, list_of(:shop) do
      arg :category, :shop_category

      resolve &Resolvers.Shop.all/2
    end
  end

end