defmodule MyList do
  import Enum, only: [at: 2, sort: 1, to_list: 1]

  def all_ascii?(chars), do: all?(chars, &(&1 in 32..126))

  def anagram?(word1, word2), do: sort(word1) == sort(word2)

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

  def none?([], _func), do: true
  def none?([x|xs], func), do: !func.(x) && none?(xs, func) || false

  def is_prime?(n) when n <= 1, do: false
  def is_prime?(n), do: none?(span(2, n - 1), &(rem(n, &1) == 0))

  def primes_upto(to) when to <= 1, do: []
  def primes_upto(to), do: (for n <- span(2, to), is_prime?(n), do: n)

  def all?([], _func), do: true
  def all?([x|xs], func), do: func.(x) && all?(xs, func) || false

  def each([], _func), do: []
  def each([x|xs], func), do: [func.(x) | each(xs, func)]

  def filter([], _func), do: []
  def filter([x|xs], func) do
    func.(x) && [x|filter(xs, func)] || filter(xs, func)
  end

  def split(_, count) when count < 0, do: raise "TODO: Negative count."
  def split([], _count), do: [[], []]
  def split(xs, 0), do: [[], [xs]]
  def split([x|xs], count) do
    [a, b] = split(xs, count - 1)
    [[x|a], b]
  end

  def take(_, count) when count < 0, do: raise "TODO: Negative count."
  def take([], _count), do: []
  def take(_, 0), do: []
  def take([x|xs], count), do: [x|take(xs, count - 1)]

  def flatten([]), do: []
  def flatten([x|xs]) when is_list(x), do: flatten(x) ++ flatten(xs)
  def flatten([x|xs]), do: [x|flatten(xs)]

  # # -- José Valim version -----------------------

  # def flatten(list), do: do_flatten(list, [])

  # def do_flatten([h|t], tail) when is_list(h) do
  #   do_flatten(h, do_flatten(t, tail))
  # end

  # def do_flatten([h|t], tail) do
  #   [h|do_flatten(t, tail)]
  # end

  # def do_flatten([], tail) do
  #   tail
  # end
  # ---------------------------------------------

  # def split(xs, count), do: split(xs, count, [[], []])

  # [1,2,3], 2
  # 1 [2,3], 2
  # def split(_, 0, pairs), do: pairs

  # def split([x|xs], count, pairs = [a, b]) do
  #   IO.inspect pairs
  #   split(xs, count - 1, [[x|a], b])
  # end

  # def split([], _count, pairs) do
  #   pairs
  # end
end

# [1,2,3], 0, &(&2 + (&1 + 1)) = 2 + 3 + 4 = 9
# MyList.reduce [1,2,3], 0, &(&2 + (&1 + 1))

# [1,2,3]
# [1|square([2,3])]
# [1|[2|square([3])]]
# [1|[2|[3|square([])]]]
