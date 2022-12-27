defmodule ExampleGenServer.ExamplePollingTask do
  use Task

  def start_link(message) do
    Task.start_link(fn ->
    repeatedly_log_hello(message)
    end)
  end

  defp repeatedly_log_hello(message) do
    IO.inspect "ExamplePollingTask: #{message}"
    Process.sleep(:timer.seconds(2))
    repeatedly_log_hello(message)
  end
end