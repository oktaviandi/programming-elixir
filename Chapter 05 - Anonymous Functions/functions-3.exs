fizzbuz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

fizzbuzz_caller = fn
  n -> fizzbuz.(rem(n, 3), rem(n, 5), n)
end

IO.puts fizzbuzz_caller.(10)
IO.puts fizzbuzz_caller.(11)
IO.puts fizzbuzz_caller.(12)
IO.puts fizzbuzz_caller.(13)
IO.puts fizzbuzz_caller.(14)
IO.puts fizzbuzz_caller.(15)
IO.puts fizzbuzz_caller.(16)
