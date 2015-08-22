defmodule FizzBuzz do

  def upto_case(final), do: 1..final |> Enum.map(&fizzbuzz_case/1)

  def fizzbuzz_case(n) do
    case {rem(n, 3), rem(n, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _      -> n
    end
  end

  def upto_cond(final), do: 1..final |> Enum.map(&fizzbuzz_cond/1)

  def fizzbuzz_cond(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      rem(n, 3) == 0                    -> "Fizz"
      rem(n, 5) == 0                    -> "Buzz"
      true                              -> n
    end
  end

  def upto_guard(final), do: 1..final |> Enum.map(&fizzbuzz_guard/1)

  def fizzbuzz_guard(n) when rem(n, 3) == 0 and rem(n, 5) == 0, do: "FizzBuzz"
  def fizzbuzz_guard(n) when rem(n, 3) == 0, do: "Fizz"
  def fizzbuzz_guard(n) when rem(n, 5) == 0, do: "Fizz"
  def fizzbuzz_guard(n), do: n
end
