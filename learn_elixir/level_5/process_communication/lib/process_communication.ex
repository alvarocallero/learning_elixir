defmodule ProcessCommunication do
  @five_seconds :timer.seconds(5)

  def create_process do
    IO.inspect "Starting Process from #{inspect self()}"

    spawn(fn ->
      current_pid = self()

      receive do
        msg -> IO.inspect("#{inspect current_pid} - Received Message: #{inspect msg}")
#      after
#        @five_seconds -> IO.puts("Five seconds passed")
      end
    end)
  end
end
