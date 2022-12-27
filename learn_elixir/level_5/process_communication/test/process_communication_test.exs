defmodule ProcessCommunicationTest do
  use ExUnit.Case
  doctest ProcessCommunication

  test "greets the world" do
    assert ProcessCommunication.hello() == :world
  end
end
