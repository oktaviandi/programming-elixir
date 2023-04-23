defmodule EnumFlatten do
  def flatten(list) when is_list(list), do: do_flatten(list, [])
  defp do_flatten([], result), do: Enum.reverse(result)
  defp do_flatten([head | tail], result) when is_list(head), do: do_flatten(head ++ tail, result)
  defp do_flatten([head | tail], result) when not is_list(head), do: do_flatten(tail, [head | result])
end
