defmodule MyGraphqlServerWeb.Shop do

  @shops [%{
    id: 1,
    name: "Clothing Shop 1",
    category: :CLOTHING,
    address: %{
      country: "USA",
      city: "New York"
    }
  },
    %{
      id: 2,
      name: "Custom Clothing Shop",
      category: :CLOTHING,
      address: %{
          country: "USA",
          city: "Mississipi"
          }
    },
    %{
      id: 1,
      name: "Hardware Shop",
      category: :HARDWARE,
      address: %{
               country: "Canada",
               city: "Vancoucer"
               }
    },
    %{
      id: 1,
      name: "Pool Shop",
      category: :HARDWARE,
             address: %{
             country: "Canada",
             city: "Quebec"
             }
    }]

  def all(%{category: category}) do
    case Enum.filter(@shops, &(&1.category === category)) do
      [] -> {:error, %{message: "not found", details: %{category: category}}}
      shops -> {:ok, shops}
    end
  end

  def all(_) do
    {:ok, @shops}
  end

  def find(%{id: id}) do
    case Enum.find(@shops, &(&1.id === id)) do
      nil -> {:error, %{message: "not found", details: %{id: id}}}
      shop -> {:ok, shop}
    end
  end

  def update(id, params) do
    with {:ok, shop} <- find(%{id: id}) do
      {:ok, Map.merge(shop, params)}
    end
  end

end