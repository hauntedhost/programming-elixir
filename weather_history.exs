defmodule WeatherHistory do
  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 28, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 26, 22, 0.095],
      [1366232822, 27, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end

  def at_location([], _n), do: []
  def at_location([ head = [ _, n, _, _ ] | tail], n) do
    [ head | at_location(tail, n) ]
  end
  def at_location([ _ | tail], n), do: at_location(tail, n)

  def rain_at_location([], _n), do: []
  def rain_at_location([ [ _time, n, _temp, rain ] | tail], n) do
    [ [n, rain] | rain_at_location(tail, n) ]
  end
  def rain_at_location([ _ | tail], n), do: rain_at_location(tail, n)
end
