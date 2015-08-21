defmodule MyString do
  import Enum, only: [join: 2, map: 2, max_by: 2, sort: 2]
  import String, only: [to_atom: 1, to_integer: 1]

  def calculate(expression)
    when is_list(expression),
    do: calculate(to_string(expression))

  def calculate(expression) do
    [num1, operator, num2] = parse_expression(expression)
    apply(Kernel, to_atom(operator), map([num1, num2], &to_integer/1))
  end

  def center(words) do
    words
    |> sort_by_length
    |> map_padding
    |> join("\n")
  end

  def longest(words), do: max_by(words, &(String.length(&1)))

  def sort_by_length(words), do: sort(words, &(length_asc(&1, &2)))

  # private

  defp length_asc(a, b), do: String.length(a) < String.length(b)

  defp map_padding(words) do
    max_length = longest(words) |> String.length
    words |> Enum.map &(String.rjust(&1, padding(&1, max_length)))
  end

  defp padding(word, max_length) do
    len = String.length(word)
    div(max_length - len, 2) + len
  end

  defp parse_expression(expression) do
    regex = ~r/(?<num1>\d+)\s?(?<operator>[\*\/+-])\s?(?<num2>\d+)/
    Regex.run(regex, expression, capture: :all_but_first)
  end
end
