defmodule Parallel do

  @moduledoc """
  Map a funcion in parallel. Example:
    iex> Parallel.pmap 1..10, &(&1 * &1)
    [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
  """

  def pmap(collection, fun) do
    collection
    |> spawn_links(fun)
    |> collect_results
  end

  defp spawn_links(collection, fun) do
    me = self
    Enum.map(collection, fn(elem) ->
      spawn_link fn -> send(me, { self, fun.(elem)}) end
    end)
  end

  defp collect_results(links) do
    Enum.map(links, fn(pid) ->
      receive do {^pid, result} -> result end
    end)
  end
end
