defmodule WeatherHistory do
  def for_location_27([]), do: []

  def for_location_27([[timestamp, 27, temperature, rainfall] | tail]),
    do: [[timestamp, 27, temperature, rainfall] | for_location_27(tail)]

  def for_location_27([_ | tail]), do: for_location_27(tail)

  def for_location([], _), do: []

  def for_location([ head = [_, target, _, _] | tail], target),
    do: [head | for_location(tail, target)]

  def for_location([_ | tail], target), do: for_location(tail, target)

  def test_data do
    [
      [1_366_225_622, 26, 15, 0.125],
      [1_366_225_622, 27, 15, 0.45],
      [1_366_225_622, 28, 21, 0.25],
      [1_366_229_222, 26, 19, 0.081],
      [1_366_229_222, 27, 17, 0.468],
      [1_366_229_222, 28, 15, 0.60],
      [1_366_232_822, 26, 22, 0.095],
      [1_366_232_822, 27, 21, 0.05],
      [1_366_232_822, 28, 24, 0.03],
      [1_366_236_422, 26, 17, 0.025]
    ]
  end
end
