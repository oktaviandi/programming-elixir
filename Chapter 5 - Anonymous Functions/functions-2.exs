fizzbuz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

IO.puts fizzbuz.(0, 0, 3)
IO.puts fizzbuz.(0, 1, 3)
IO.puts fizzbuz.(1, 0 , 3)
IO.puts fizzbuz.(1, 2 , 3)
