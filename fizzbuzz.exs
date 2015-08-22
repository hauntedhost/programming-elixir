defmodule FizzBuzz do

  def upto(final), do: 1..final |> Enum.map(&fizzbuzz/1)

  def fizzbuzz(num) do
    ""
    |> concat_if("Fizz", rem(num, 3) == 0)
    |> concat_if("Buzz", rem(num, 5) == 0)
    |> num_if_empty(num)
  end

  defp concat_if(a, b, predicate), do: predicate && a <> b || a

  defp num_if_empty("", num), do: num
  defp num_if_empty(fizzbuzz, _), do: fizzbuzz
end
