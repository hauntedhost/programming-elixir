defmodule FibServer.Solver do

  def fib(scheduler_pid) do
    send(scheduler_pid, {:ready, self})
    receive do
      {:fib, n, client_pid} ->
        send(client_pid, {:answer, n, fib_calc(n), self})
        fib(scheduler_pid)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end
