defmodule SocketServerWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :socket_server
  use Absinthe.Phoenix.Endpoint

  # To hit the socket url go to: ws://localhost:4000/socket
  # To hit secure socket url go to: wss://localhost:4000/socket
  socket "/socket", SocketServerWeb.UserSocket, websocket: true

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug SocketServerWeb.Router
end
