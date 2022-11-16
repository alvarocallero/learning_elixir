defmodule EctoTestWeb.ShopView do
  use EctoTestWeb, :view
  alias EctoTestWeb.ShopView

  def render("index.json", %{shops: shops}) do
    shops = EctoTest.Repo.preload(shops, :address)
    %{data: render_many(shops, ShopView, "shop.json")}
  end

  def render("show.json", %{shop: shop}) do
    %{data: render_one(shop, ShopView, "shop.json")}
  end

  def render("shop.json", %{shop: shop}) do
    shop_return = %{
      id: shop.id,
      name: shop.name
    }
    address = find_shop_address(shop)
    Map.put(shop_return, :address, address)
  end

  defp find_shop_address(shop) do
      shop
      |> EctoTest.Repo.preload(:address)
      |> Map.get(:address)
      |> render_one(EctoTestWeb.AddressView, "address.json")
  end

end
