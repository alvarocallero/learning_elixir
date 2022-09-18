defmodule PatternMatching do

  """
  Convert the keys of a map to String
"""
  def parse(%{} = map) do
    Enum.into(map, %{}, fn {key, value} ->
      {Atom.to_string(key), parse(value)}
    end)
  end

  def parse([_|_] = list) do
    Enum.map(list, &parse/1)
  end

  def parse(a) do
    a
  end

end