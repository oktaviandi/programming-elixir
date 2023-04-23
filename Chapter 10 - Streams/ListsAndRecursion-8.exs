defmodule Order do
  def sample_orders do
    [
      [id: 123, ship_to: :NC, net_amount: 100.00],
      [id: 124, ship_to: :OK, net_amount: 35.50],
      [id: 125, ship_to: :TX, net_amount: 24.00],
      [id: 126, ship_to: :TX, net_amount: 44.80],
      [id: 127, ship_to: :NC, net_amount: 25.00],
      [id: 128, ship_to: :MA, net_amount: 10.00],
      [id: 129, ship_to: :CA, net_amount: 102.00],
      [id: 130, ship_to: :NC, net_amount: 50.00]
    ]
  end

  def sample_tax_rates do
    [NC: 0.075, TX: 0.08]
  end

  def calculate(orders, tax_rate) when is_list(orders) and is_list(tax_rate) do
    orders
    |> Enum.map(&(calculate_total(&1, tax_rate)))
  end

  defp calculate_total(order, tax_rate) do
    tax = Keyword.get(tax_rate, order[:ship_to], 0)
    total_amount = order[:net_amount] + order[:net_amount] * tax
    Keyword.put_new(order, :total_amount, total_amount)
  end
end
