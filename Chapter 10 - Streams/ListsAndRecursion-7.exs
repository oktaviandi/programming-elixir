defmodule Prime do
  def span(from, to) when is_integer(from) and is_integer(to) and from < to,
    do: span_generator(from, to, [])

  defp span_generator(from, to, list) do
    case from do
      value when value <= to -> span_generator(value + 1, to, [value | list])
      value when value > to -> Enum.reverse(list)
    end
  end

  def prime_checker(number) when is_number(number) and number > 1 do
    for prime <- Enum.to_list(2..number), is_prime(prime), do: prime
  end

  def prime_checker_pipe(number) when is_number(number) and number > 1 do
    span(2, number)
    |> Enum.filter(&(is_prime(&1)))
  end

  defp is_prime(n) when is_number(n) and n > 0 do
    case n do
      number when number < 4 -> true
      number when number <= 7 and rem(number, 2) != 0 -> true
      number when number <= 7 and rem(number, 2) == 0 -> false
      number -> span(2, div(number, 2) - 1) |> check_divisor(number)
    end
  end

  defp check_divisor([], _), do: true
  defp check_divisor([head | tail], number) do
    case rem(number, head) == 0 do
      true -> false
      false -> check_divisor(tail, number)
    end
  end
end
