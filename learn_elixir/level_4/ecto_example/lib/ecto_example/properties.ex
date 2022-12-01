defmodule EctoExample.Properties do
  alias EctoExample.{Repo, Properties.House}

  def all_houses(params) do
    params
    |> Enum.reduce(House, &convert_field_to_query/2)
    |> Repo.all
  end

  def convert_field_to_query({:price_lt, value}, query) do
    House.by_lt_than_price(query, value)
  end

  def convert_field_to_query({:name, value}, query) do
    House.or_by_searched_name(query, value)
  end

  def convert_field_to_query({:price_gt, value}, query) do
    House.by_gt_than_price(query, value)
  end

  def convert_field_to_query({:between_price, {start_price, end_price}}, query) do
    query
    |> House.by_gt_than_price(start_price)
    |> House.by_lt_than_price(end_price)
  end

  def convert_field_to_query({:by_address, value}, query) do
    House.by_address(query, value)
  end


end