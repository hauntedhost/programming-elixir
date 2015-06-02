defmodule Puzzle do
  import Enum

  def interleave([ha|ta], [hb|tb]), do: [ha, hb | interleave(ta, tb)]
  def interleave(_, _), do: []

  def combination(0, _), do: [[]]
  def combination(_, []), do: []
  def combination(n, [x|xs]) do
    (for ys <- combination(n - 1, xs), do: [x|ys]) ++ combination(n, xs)
  end

  def sum_eq_n?(0, []), do: true
  def sum_eq_n?(n, [n]), do: true
  def sum_eq_n?(n, xs), do: any?(pairs(xs), &(sum(&1) == n))

  def pairs(xs), do: combination(2, xs)

  # iterative version of combination for pairs
  # def pairs([_x]), do: []
  # def pairs(xs) do
  #   0..(length(xs) - 2) |> flat_map fn (i) ->
  #     (i + 1)..(length(xs) - 1) |> map fn (j) ->
  #       [at(xs, i), at(xs, j)]
  #     end
  #   end
  # end
end
