defmodule MyString do
  # Reuse all functions
  def anagram?(word1, word2) when is_list(word1) and is_list(word2) do
    convert(word1) == convert(word2) |> String.reverse()
  end

  defp convert(input) do
    List.to_string(input)
  end
end
