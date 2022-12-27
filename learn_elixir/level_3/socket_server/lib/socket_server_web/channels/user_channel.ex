defmodule SocketServerWeb.UserChannel do
  use SocketServerWeb, :channel

  # this function will have users topic
  def join("users", _payload, socket) do
    {:ok, socket}
  end

  # essentially responds to
  # different messages that are pushed to our server from the client
  # Every time a new user is created then all the users that are subrscribed to the topic of users will be notified
  # about the creation of the new user
  def handle_in("new_user", %{"id" => id}, socket) do
    broadcast(socket, "new_user", %{"id" => id})

    {:reply, %{"accepted" => true}, socket}
  end
end
