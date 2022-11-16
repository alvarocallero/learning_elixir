defmodule EctoTestWeb.ShopControllerTest do
  use EctoTestWeb.ConnCase

  import EctoTest.RetailFixtures

  alias EctoTest.Retail.Shop

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all shops", %{conn: conn} do
      conn = get(conn, Routes.shop_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create shop" do
    test "renders shop when data is valid", %{conn: conn} do
      conn = post(conn, Routes.shop_path(conn, :create), shop: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.shop_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.shop_path(conn, :create), shop: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update shop" do
    setup [:create_shop]

    test "renders shop when data is valid", %{conn: conn, shop: %Shop{id: id} = shop} do
      conn = put(conn, Routes.shop_path(conn, :update, shop), shop: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.shop_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, shop: shop} do
      conn = put(conn, Routes.shop_path(conn, :update, shop), shop: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete shop" do
    setup [:create_shop]

    test "deletes chosen shop", %{conn: conn, shop: shop} do
      conn = delete(conn, Routes.shop_path(conn, :delete, shop))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.shop_path(conn, :show, shop))
      end
    end
  end

  defp create_shop(_) do
    shop = shop_fixture()
    %{shop: shop}
  end
end
