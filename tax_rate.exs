defmodule TaxRate do

  def add_total(order = [_, state, net]) do
    tax_rate = Keyword.get(tax_rates, state, 0)
    tax      = net * tax_rate
    total    = net + tax
    order ++ [total]
  end

  def orders_from_file(filename \\ "orders.csv") do
    File.stream!(filename) |> Stream.map(&(parse_order_line(&1)))
  end

  def orders_with_totals(orders) do
    orders |> Enum.map(&add_total/1)
  end

  defp parse_order_line(order) do
    [id, state, net] = order |> String.rstrip(?\n) |> String.split(",")
    [String.to_integer(id), String.to_atom(state), String.to_float(net)]
  end

  def tax_rates do
    [ NC: 0.075, TX: 0.08 ]
  end
end
