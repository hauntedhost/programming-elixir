defmodule Sum do
  def to(0), do: 0
  def to(n), do: n + to(n - 1)
end
