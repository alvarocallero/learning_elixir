defmodule EctoExample.Properties.Owner do
  use Ecto.Schema

  import Ecto.Changeset

  schema "owners" do
    field :name, :string
    many_to_many :houses, EctoExample.Properties.House, join_through: "owners_houses"
  end

  @required_fields [:name]

  def changeset(owner = %EctoExample.Properties.Owner{}, params) do
    owner
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

end
