defmodule Guess do
  def guess(actual, lower..upper) when actual >= lower and actual <= upper do 
    half = div(upper + lower, 2)
    IO.puts "Is it #{half}"
    make_guess(actual, half, lower..upper)
  end

  def make_guess(num, num, _) do
    num 
  end

  def make_guess(actual, half, lower.._) when actual < half do
    guess(actual, lower..half)
  end 

  def make_guess(actual, half, _..upper) when actual > half do
    guess(actual, half..upper)
  end  
end
