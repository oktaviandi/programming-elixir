defmodule MyString4 do
  def calculate(input) when is_list(input) do
    [num1, ops, num2] = List.to_string(input) |> String.split(" ")

    {number1, _} = Integer.parse(num1)
    {number2, _} = Integer.parse(num2)
    case ops == "/" and num2 == "0" do
      true -> raise "Division by zero"
      false -> do_calculate(number1, ops, number2)
    end
  end

  defp do_calculate(num1, ops, num2) when is_integer(num1) and is_integer(num2) do
    case ops do
      "+" -> num1 + num2
      "-" -> num1 - num2
      "*" -> num1 * num2
      "/" -> num1 / num2
      _ -> raise "Invalid operand"
    end
  end
end
