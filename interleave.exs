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

defmodule Puzzle do
  def interleave([], []) do
    []
  end

  def interleave(as, []) do
    as
  end

  def interleave([], bs) do
    bs
  end

  def interleave([ha|ta], [hb|tb]) do
    [ha, hb] ++ interleave(ta, tb)
  end
end

# or if you don't care about unmatched pairs
defmodule Puzzle do
  def interleave([ha|ta], [hb|tb]) do
    [ha, hb] ++ interleave(ta, tb)
  end

  def interleave(_, _) do
    []
  end
end

# a = [1,2,3]
# b = ["a", "b", "c"]
# interleave.(a,b)

