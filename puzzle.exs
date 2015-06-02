# interleave = fn (a, b) ->
#   Enum.reduce(Enum.with_index(a), [], fn (ai, memo) ->
#     index = elem(ai, 1)
#     x = elem(ai, 0)
#     y = at(b, index)
#     memo ++ [x, y]
#   end)
# end

# defmodule Puzzle do
#   import Enum, only: [ reduce: 3, with_index: 1 ]

#   def pair({ a, index }, bs) do
#     b = at(bs, index)
#     [a, b]
#   end

#   def interleave(as, bs) do
#     with_index(as)
#     |> reduce([], fn (ai, memo) -> memo ++ pair(ai, bs) end)
#   end

#   def interleave(a, b) do
#     with_index(a)
#     |> reduce([], fn (ai, memo) ->
#       index = elem(ai, 1)
#       x = elem(ai, 0)
#       y = at(b, index)
#       memo ++ [x, y]
#     end)
#   end
# end

# defmodule Puzzle do
#   def interleave([], []) do
#     []
#   end

#   def interleave(as, []) do
#     as
#   end

#   def interleave([], bs) do
#     bs
#   end

#   def interleave([ha|ta], [hb|tb]) do
#     [ha, hb] ++ interleave(ta, tb)
#   end
# end

# or if you don't care about unmatched pairs
# defmodule Puzzle do
#   def interleave([ha|ta], [hb|tb]) do
#     [ha, hb] ++ interleave(ta, tb)
#   end

#   def interleave(_, _) do
#     []
#   end
# end

# a = [1,2,3]
# b = ["a", "b", "c"]
# interleave.(a,b)

defmodule Puzzle do
  import Enum

  def interleave([ha|ta], [hb|tb]) do
    [ha, hb | interleave(ta, tb)]
  end

  def interleave(_, _) do
    []
  end

  # solution = [[1, 2], [1, 3], [2, 3]]
  # solution positions [0, 1], [0, 2], [1, 2]
  # a = [1,2,3]
  # 0
  # 1
  # 2
  # 1
  # 2
  # 2

  # erlang
  # comb(0,_) ->
  #     [[]];
  # comb(_,[]) ->
  #     [];
  # comb(N,[H|T]) ->
  #     [[H|L] || L <- comb(N-1,T)]++comb(N,T).

  # [[1,2],[1,3],[2,3]]
  def combination(0, _), do: [[]]
  def combination(_, []), do: []
  def combination(n, [x|xs]) do
    (for ys <- combination(n - 1, xs), do: [x|ys]) ++ combination(n, xs)
    # for y <- combination(n - 1, xs), do: [x|y] ++ combination(n, xs)
    # [x | for y <- combination(n - 1, xs), do: y] ++ combination(n, xs)
    # [x | combination(n - 1, xs) ++ combination(n, xs)]
    # [x | for l <- combination(n - 1, xs), do: [x|l]] ++ combination(n, xs)
    # [[x|l] l <- combination(n - 1, xs)] ++ combination(n, xs)
    # [x | combination(n - 1, xs)] ++ combination(n, xs)
    # map combination(n - 1, xs) ++ combination(n, xs), fn (n) -> [x|n] end
    # ys = combination(n - 1, xs)
    # zs = combination(n, xs)
    # map (ys ++ zs), fn (n) -> [x] ++ n end
    # [x | combination(n - 1, xs) ++ combination(n, xs)]
    # [x | combination(n - 1, xs) ++ combination(n, xs)]
  end

  # 2, [1,2,3]

  def pairs([_x]), do: []

  def pairs(xs) do
    0..(length(xs) - 2) |> flat_map fn (i) ->
      (i + 1)..(length(xs) - 1) |> map fn (j) ->
        [at(xs, i), at(xs, j)]
      end
    end
  end

  def sum_eq_n?([], 0), do: true
  def sum_eq_n?([n], n), do: true
  def sum_eq_n?(xs, n), do: any?(pairs(xs), &(sum(&1) == n))
end
