defmodule ExampleGenServer.ExampleAgent do
  use Agent

  @default_name ExampleGenServer.ExampleAgent




  def start_link(opts \\ []) do
    initial_state = []
    opt = Keyword.put_new(opts, :name, @default_name)
    Agent.start_link(ExampleGenServer.ExampleAgent, initial_state, opts)
  end

  def add_message(name \\ @default_name, message) do
    Agent.update(name, fn state ->
      [message | state]
    end)
  end

  def get_all_messages(name \\ @default_name) do
    Agent.get(name, fn state ->
      {length(state), state}
    end)
  end

end