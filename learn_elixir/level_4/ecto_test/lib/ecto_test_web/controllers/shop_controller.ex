defmodule EctoTestWeb.ShopController do
  use EctoTestWeb, :controller

  alias EctoTest.Retail
  alias EctoTest.Retail.Shop

  action_fallback EctoTestWeb.FallbackController

  def index(conn, _params) do
    shops = Retail.list_shops()
    render(conn, "index.json", shops: shops)
  end

  def create(conn, %{"shop" => shop_params}) do
    with {:ok, %Shop{} = shop} <- Retail.create_shop(shop_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.shop_path(conn, :show, shop))
      |> render("show.json", shop: shop)
    end
  end

  def show(conn, %{"id" => id}) do
    shop = Retail.get_shop!(id)
    render(conn, "show.json", shop: shop)
  end

  def update(conn, %{"id" => id, "shop" => shop_params}) do
    shop = Retail.get_shop!(id)

    with {:ok, %Shop{} = shop} <- Retail.update_shop(shop, shop_params) do
      render(conn, "show.json", shop: shop)
    end
  end

  def delete(conn, %{"id" => id}) do
    shop = Retail.get_shop!(id)

    with {:ok, %Shop{}} <- Retail.delete_shop(shop) do
      send_resp(conn, :no_content, "")
    end
  end
end
