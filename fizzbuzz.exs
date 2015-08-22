defmodule FizzBuzz do

  def upto(final), do: 1..final |> Enum.map(&fizzbuzz/1)

  def fizzbuzz(n) when rem(n, 3) == 0 and rem(n, 5) == 0, do: "FizzBuzz"
  def fizzbuzz(n) when rem(n, 3) == 0, do: "Fizz"
  def fizzbuzz(n) when rem(n, 5) == 0, do: "Fizz"
  def fizzbuzz(n), do: n
end
