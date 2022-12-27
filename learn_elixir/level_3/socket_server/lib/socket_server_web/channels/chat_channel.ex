defmodule SocketServerWeb.ChatChannel do
  use SocketServerWeb, :channel

  """
    And so this is a very simple, we now have created a chat room that has an id
    and we'll broadcast messages to all those individual chat rooms depending on which chat room socket
    sent that message
  """

  def join("chat_room:" <> id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "user is not authorized"}}
    end
  end

  def handle_in("send message", %{"message" => message}, socket) do
    broadcast("send_message", socket, %{"message" => message})

    {:noreply, socket}
  end

  defp authorized?(%{"user_id" => _}), do: true
  defp authorized?(_), do: false
end
