defmodule MyGraphqlServerWeb.Schema do
  use Absinthe.Schema


  import_types MyGraphqlServerWeb.Types.Shop
  import_types MyGraphqlServerWeb.Schema.Queries.Shop
  import_types MyGraphqlServerWeb.Schema.Mutations.Shop

  query do
    import_fields :shop_queries
  end

  mutation do
    import_fields :shop_mutations
  end
end