defmodule EctoExample.Properties.House do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  schema "houses" do
    field :price, :integer
    field :is_occupied, :boolean
    field :name, :string

    belongs_to :address, EctoExample.Properties.Address

    many_to_many :owners, EctoExample.Properties.Owner, join_through: "owners_houses"

  end

  @required_params [:price]
  @available_parameters [:address_id, :is_occupied, :name | @required_params]

  def changeset(struct = %EctoExample.Properties.House{}, params) do
    struct
    |> EctoExample.Repo.preload(:owners)
    |> cast(params, @available_parameters)
    |> validate_required(@required_params)
    |> validate_number(:price, greater_than: 0, message: "The price has to be greater than 0")
    |> validate_length(:name, min: 1, max: 10, message: "Must be between 1 and 20")
    |> cast_assoc(:owners)
  end

  def by_gt_than_price(query \\ EctoExample.Properties.House, price) do
    where(query, [h], h.price > ^price)
  end

  def by_lt_than_price(query \\ EctoExample.Properties.House, price) do
    where(query, [h], h.price < ^price)
  end

  def or_by_searched_name(query \\ EctoExample.Properties.House, name) do
    search_query = "%#{name}%"
    or_where(query, [h], ilike(h.name, ^search_query))
  end

  def join_address(query \\ EctoExample.Properties.House) do
    join(query, :inner, [h], a in assoc(h, :address), as: :address)
  end

  def by_address(query \\ join_address(), address) do
    where(query, [address: a], a.country == ^address)
  end

end