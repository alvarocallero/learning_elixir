defmodule EctoTest.RetailTest do
  use EctoTest.DataCase

  alias EctoTest.Retail

  describe "addresses" do
    alias EctoTest.Retail.Address

    import EctoTest.RetailFixtures

    @invalid_attrs %{city: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Retail.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Retail.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{city: "some city"}

      assert {:ok, %Address{} = address} = Retail.create_address(valid_attrs)
      assert address.city == "some city"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retail.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      update_attrs = %{city: "some updated city"}

      assert {:ok, %Address{} = address} = Retail.update_address(address, update_attrs)
      assert address.city == "some updated city"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Retail.update_address(address, @invalid_attrs)
      assert address == Retail.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Retail.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Retail.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Retail.change_address(address)
    end
  end

  describe "shops" do
    alias EctoTest.Retail.Shop

    import EctoTest.RetailFixtures

    @invalid_attrs %{name: nil}

    test "list_shops/0 returns all shops" do
      shop = shop_fixture()
      assert Retail.list_shops() == [shop]
    end

    test "get_shop!/1 returns the shop with given id" do
      shop = shop_fixture()
      assert Retail.get_shop!(shop.id) == shop
    end

    test "create_shop/1 with valid data creates a shop" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Shop{} = shop} = Retail.create_shop(valid_attrs)
      assert shop.name == "some name"
    end

    test "create_shop/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Retail.create_shop(@invalid_attrs)
    end

    test "update_shop/2 with valid data updates the shop" do
      shop = shop_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Shop{} = shop} = Retail.update_shop(shop, update_attrs)
      assert shop.name == "some updated name"
    end

    test "update_shop/2 with invalid data returns error changeset" do
      shop = shop_fixture()
      assert {:error, %Ecto.Changeset{}} = Retail.update_shop(shop, @invalid_attrs)
      assert shop == Retail.get_shop!(shop.id)
    end

    test "delete_shop/1 deletes the shop" do
      shop = shop_fixture()
      assert {:ok, %Shop{}} = Retail.delete_shop(shop)
      assert_raise Ecto.NoResultsError, fn -> Retail.get_shop!(shop.id) end
    end

    test "change_shop/1 returns a shop changeset" do
      shop = shop_fixture()
      assert %Ecto.Changeset{} = Retail.change_shop(shop)
    end
  end
end
