defmodule GraphqlApi.RequestsManager do
  use Agent

  @default_name GraphqlApi.RequestsManager

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, @default_name)
    Agent.start_link(fn -> %{} end, opts)
  end

  def add_request_hit(name \\ @default_name, request_name) do
    Agent.update(name, fn state ->
      Map.put(state, request_name, Map.get(state, request_name, 0) + 1)
    end)
  end

  def get_request_hits(name \\ @default_name, request_name) do
    Agent.get(name, fn state ->
      Map.get(state, request_name)
    end)
  end
end
