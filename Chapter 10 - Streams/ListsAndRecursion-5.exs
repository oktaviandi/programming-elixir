defmodule EnumStream do
  def all?(list, function) when is_list(list) and is_function(function) do
    do_all(list, function)
  end

  defp do_all([], _), do: true
  defp do_all([ head | tail], function) do
    case function.(head) do
      true -> do_all(tail, function)
      false -> false
    end
  end

  def each(list, function) when is_list(list) and is_function(function) do
    do_each(list, function)
  end
  defp do_each([], _), do: :ok
  defp do_each([head | tail], function) do
    function.(head)
    do_each(tail, function)
  end

  def filter(list, function) when is_list(list) and is_function(function) do
    do_filter(list, function, [])
  end
  defp do_filter([], _, result), do: Enum.reverse(result)
  defp do_filter([ head | tail], function, result) do
    case function.(head) do
      true -> do_filter(tail, function, [head | result])
      false -> do_filter(tail, function, result)
    end
  end

  def split(list, condition) when is_list(list), do: do_split(list, condition, [])
  defp do_split([], _, result), do: {[], Enum.reverse(result)}
  defp do_split([head | tail], condition, result) do
    case head == condition do
      true -> {tail, Enum.reverse([head | result])}
      false -> do_split(tail, condition, [head | result])
    end
  end

  def take(list, number) when is_list(list) and is_number(number), do: do_take(list, number, [])
  defp do_take([], _, result), do: Enum.reverse(result)
  defp do_take(_, 0, result), do: Enum.reverse(result)
  defp do_take([head | tail], number, result) when number > 0 do
    do_take(tail, number - 1, [head | result])
  end
end
