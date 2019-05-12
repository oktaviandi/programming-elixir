defmodule MyList do
  def square([]), do: []
  def square([head | tail]), do: [ head * head | square(tail)]

  def add_1([]), do: []
  def add_1([head | tail]), do: [head + 1 | add_1(tail)]

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], initial, _func), do: initial
  def reduce([head | tail], initial, func), do: reduce(tail, func.(head, initial), func)

  def sum(list), do: reduce(list, 0, &(&1 + &2))

  def map_sum(list), do: sum(map(list, &(&1 * &1)))

  def max(list), do: reduce(list, 0, &(max(&1, &2)))
end 