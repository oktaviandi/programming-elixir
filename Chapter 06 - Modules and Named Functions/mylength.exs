# Have to rename the function to my_length to prevent conflict with built-in length function
defmodule Length do
  def my_length([]), do: 0
  def my_length([_ | tail]), do: 1 + my_length(tail)
end