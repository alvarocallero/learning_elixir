defmodule ExampleGenServer.ExampleGenServer do
  @moduledoc false

  use GenServer

  @default_name ExampleGenServer.ExampleGenServer

  #API
  def start_link(opts \\ []) do
    inital_state = []
    opts = Keyword.put_new(opts, :name, ExampleGenServer.ExampleGenServer)
    GenServer.start_link(ExampleGenServer.ExampleGenServer, inital_state, opts)
  end

  def init(state) do
    {:ok, state}
  end

  def add_message(name \\ @default_name, message) do
    GenServer.cast(name, {:add_message, message})
  end

  def get_all_messages(name \\ @default_name) do
    GenServer.call(name, :get_all_messages)
  end

  #Server
  def handle_cast({:add_message, message}, state) do
    IO.inspect "handle_cast: :add_message hit with: #{message}"
    state = [message | state]
    IO.inspect "#{length(state)} Messages Received Total"
    {:noreply, state}
  end

  def handle_call(:get_all_messages, from_pid, state) do
    IO.inspect "handle_call: :get_all_messages called from #{from_pid}"
    num_messages = length(state)
    IO.inspect "Returning #{num_messages} messages"
    {:reply, {num_messages, state}, state}
  end

  def handle_info(:random_message, state) do
    IO.inspect "handle:info: :random_message hit"
    {:noreply, state}
  end

end