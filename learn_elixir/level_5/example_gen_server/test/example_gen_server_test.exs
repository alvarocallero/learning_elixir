defmodule ExampleGenServerTest do
  use ExUnit.Case
  doctest ExampleGenServer

  test "greets the world" do
    assert ExampleGenServer.hello() == :world
  end
end

