defmodule MyList do
  import Enum, only: [at: 2, sort: 1, to_list: 1]

  def len([]), do: 0
  def len([_|xs]), do: 1 + len(xs)

  def square([]), do: []
  def square([x|xs]), do: [x * x|square(xs)]

  def add1([]), do: []
  def add1([x|xs]), do: [x + 1|add1(xs)]

  def map([], _func), do: []
  def map([x|xs], func), do: [func.(x) | map(xs, func)]

  # sum with accumulator
  # def sum(xs), do: sum(xs, 0)
  # defp sum([], total), do: total
  # defp sum([x|xs], total), do: sum(xs, total + x)

  # without accumulator
  def sum([]), do: 0
  def sum([x|xs]), do: x + sum(xs)

  def reduce([], memo, _func), do: memo
  def reduce([x|xs], memo, func), do: reduce(xs, func.(x, memo), func)

  def mapsum([], _func), do: 0
  def mapsum([x|xs], func), do: func.(x) + mapsum(xs, func)

  def max([]), do: nil
  def max([x]), do: x
  def max([x|xs]), do: larger(x, max(xs))
  defp larger(a, b), do: sort([a, b]) |> at(1)

  # non-recursive max
  # def max(xs), do: reduce(xs, hd(xs), &(&1 > &2 && &1 || &2))

  # recursive max with accumulator
  # def max([]), do: nil
  # def max([x|xs]), do: _max(xs, x)
  # defp _max([], result), do: result
  # defp _max([x|xs], result), do: _max(xs, larger(x, result))
  # defp larger(a, b), do: (if a >= b, do: a, else: b)

  def caesar([], _n), do: ''

  def caesar([char|chars], n) do
    code = char + rem(n, 26)
    wrap = if code > ?z, do: 26, else: 0
    [code - wrap] ++ caesar(chars, n)
  end

  # abcdefghijklmnopqrstuvwxyz
  # a/97 - z/122
  # z, 1 == a
  # 122 + 1 == 97
  # 123 == 97

  # def caesar([char|chars], shift) do
  #   when char + rem(shift, 26) > ?z,
  #   do: [char + rem(shift, 26) - 26] ++ caesar(chars, shift)
  # end

  # def caesar([char|chars], shift) do
  #   [char + rem(shift, 26)] ++ caesar(chars, shift)
  # end

  def swapPairs([]), do: []
  def swapPairs([a]), do: [a]
  def swapPairs([a, b | tail]), do: [b, a | swapPairs(tail)]

  # def swap([]), do: []
  # def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  # def swap([_]), do: raise "Can't swap a list with an odd number of elements"

  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
end

# [1,2,3], 0, &(&2 + (&1 + 1)) = 2 + 3 + 4 = 9
# MyList.reduce [1,2,3], 0, &(&2 + (&1 + 1))

# [1,2,3]
# [1|square([2,3])]
# [1|[2|square([3])]]
# [1|[2|[3|square([])]]]
