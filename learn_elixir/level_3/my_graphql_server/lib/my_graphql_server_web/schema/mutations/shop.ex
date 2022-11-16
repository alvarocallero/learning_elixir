defmodule MyGraphqlServerWeb.Schema.Mutations.Shop do

  use Absinthe.Schema.Notation

  object :shop_mutations do
    field :update_shop, :shop do
      arg :id, non_null(:id)
      arg :name, :string
      arg :category, :shop_category

      resolve &MyGraphqlServerWeb.Resolvers.Shop.update/2
    end

    field :create_shop, :shop do
      arg :name, non_null(:string)
      arg :category, non_null(:shop_category)
      arg :address, non_null(:shop_address_input)

      resolve &MyGraphqlServerWeb.Resolvers.Shop.create/2
    end


  end

end
