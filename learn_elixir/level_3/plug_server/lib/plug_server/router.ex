defmodule PlugServer.Router do

  use Plug.Router

  plug :match #match the request and send trough
  plug PlugServer.PlugResponse, key: "test-key"
  plug :dispatch #dispatch the request

  #the conn element is a struct
  get "/" do
    send_resp(conn, 200, "Hello world!")
  end

  get "/other" do
    send_resp(conn, 200, "other!")
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end


end