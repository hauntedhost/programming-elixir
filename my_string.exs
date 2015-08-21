defmodule MyString do
  import Enum, only: [map: 2]
  import String, only: [to_atom: 1, to_integer: 1]

  def calculate(expression)
    when is_list(expression),
    do: calculate(to_string(expression))

  def calculate(expression) do
    [num1, operator, num2] = _parse(expression)
    apply(Kernel, to_atom(operator), map([num1, num2], &to_integer/1))
  end

  defp _parse(expression) do
    regex = ~r/(?<num1>\d+)\s?(?<operator>[\*\/+-])\s?(?<num2>\d+)/
    Regex.run(regex, expression, capture: :all_but_first)
  end
end
