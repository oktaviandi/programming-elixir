defmodule MyString do
  # Reuse all functions
  def printable?(string) do
    Enum.all?(string, &(&1 > 31 and &1 < 127))
  end
end
