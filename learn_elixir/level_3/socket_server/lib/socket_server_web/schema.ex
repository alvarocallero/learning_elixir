defmodule SocketServerWeb.Schema do
  use Absinthe.Schema

  object :user do
    field(:name, :string)
  end

  query do
    field :dummy, :boolean do
      resolve(fn _, _ -> true end)
    end
  end

  mutation do
    field :create_user, :user do
      arg(:name, non_null(:string))

      resolve(fn %{name: name}, _ ->
        {:ok, %{name: name}}
      end)
    end
  end

  subscription do
    field :user_created, :user do
      trigger(:create_user,
        topic: fn _ ->
          "new_user"
        end
      )

      config(fn _, _ ->
        {:ok, topic: "new_user"}
      end)
    end
  end
end
