defmodule EctoTest.RetailFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `EctoTest.Retail` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        city: "some city"
      })
      |> EctoTest.Retail.create_address()

    address
  end

  @doc """
  Generate a shop.
  """
  def shop_fixture(attrs \\ %{}) do
    {:ok, shop} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> EctoTest.Retail.create_shop()

    shop
  end
end
