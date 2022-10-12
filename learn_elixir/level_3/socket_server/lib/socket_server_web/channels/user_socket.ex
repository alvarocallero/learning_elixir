defmodule SocketServerWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: SocketServerWeb.Schema

 # Channels
 channel "users:*", SocketServerWeb.UserChannel
 channel "chat:*", SocketServerWeb.UserChannel


  """
With connect method we assign a user or some information to our socket
"""
  @impl true
  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  @impl true
  def id(_socket), do: nil
end
