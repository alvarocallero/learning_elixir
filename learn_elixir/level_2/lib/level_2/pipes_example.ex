defmodule PipesExample do
  """
  Split a string and check if it is greater than 2
"""
  def greater do
    "asd dfg"
    |> String.split(" ")
    |> length
    |> Kernel.>(2)
    |> Kernel.===(true)
  end

end