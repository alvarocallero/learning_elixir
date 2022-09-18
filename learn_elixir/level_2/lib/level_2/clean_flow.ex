defmodule CleanFlow do

  def case(value) do
    case value do
      %{} -> "Value was a map"
      [] -> "Value was a empty list"
      [_ | _] -> "Value was a list"
      true -> "default value"
    end
  end

  def case2(value) do
    case value do
      x when is_list(x) -> "value was a list"
      true -> "default value"
    end
  end

  def case_enhanced_for_list(value) do
    cond do
      is_nil(value) -> "Value was nil"
      true -> "default value"
    end
  end
end