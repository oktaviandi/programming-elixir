defmodule MyList do
  def len([]), do: 0
  def len([_ | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [ head * head | square(tail)]

  def add_1([]), do: []
  def add_1([head | tail]), do: [head + 1 | add_1(tail)]

  def map([], _), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]

  def reduce([], initial, _func), do: initial
  def reduce([head | tail], initial, func), do: reduce(tail, func.(head, initial), func)

  def sum(list), do: reduce(list, 0, &(&1 + &2))

  def map_sum(list), do: sum(map(list, &(&1 * &1)))

  def max(list), do: reduce(list, 0, &(max(&1, &2)))

  def caesar(list, n) when is_list(list) and is_integer(n) do
    map(list, fn char -> char_overflow(char, n) end)
  end

  defp char_overflow(char, n) when char > 64 and char < 91 do
    case char + n do
      new_char when new_char > 90 -> new_char - 26
      new_char -> new_char
    end
  end

  defp char_overflow(char, n) when char > 96 and char < 123 do
    case char + n do
      new_char when new_char > 122 -> new_char - 26
      new_char -> new_char
    end
  end

  def swap([]), do: []
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
  def swap([a, b | tail]), do: [b, a | swap tail]
end
