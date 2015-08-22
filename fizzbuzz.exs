defmodule FizzBuzz do
  def upto(final), do: upto(final, 0, [])

  defp upto(final, current, result) when current >= final, do: result

  defp upto(final, current, result) do
    fizzbuzz = ""
      |> concat_if("Fizz", rem(current, 3) == 0)
      |> concat_if("Buzz", rem(current, 5) == 0)
      |> current_if_empty(current)

    upto(final, current + 1, result ++ [fizzbuzz])
  end

  defp concat_if(a, b, predicate), do: predicate && a <> b || a

  defp current_if_empty("", current), do: current
  defp current_if_empty(fizzbuzz, _), do: fizzbuzz
end
