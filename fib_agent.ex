defmodule FibAgent do

  @moduledoc """
  Example of caching state with an Agent
  """

  def fibs(n) do
    {:ok, agent_pid} = start_link
    fib(agent_pid, n)
  end

  defp start_link do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  defp fib(pid, n) when n >= 0 do
    Agent.get_and_update(pid, &do_fib(&1, n))
  end

  defp do_fib(cache, n) do
    case cache[n] do
      nil ->
        {n_1, cache} = do_fib(cache, n - 1)
        result = n_1 + cache[n - 2]
        {result, Map.put(cache, n, result)}
      value ->
        {value, cache}
    end
  end
end
