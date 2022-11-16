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

  def context(ctx) do
    source = Dataloader.Ecto.new(MyGraphqlServer.Repo)
    dataloader = Dataloader.add_source(Dataloader.new(), MyGraphqlServer.Retail, source)
    Map.put(ctx, :loader, dataloader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end