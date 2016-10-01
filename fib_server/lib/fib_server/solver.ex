defmodule FibServer.Solver do

  # 1. immediately send a {:ready, self} message to scheduler
  #
  # 2. wait for message
  #    - if a :computer message is received, computer fib sequence and send
  #      back to messenger in a :result message. then recurse, which sends
  #      another :ready message back to scheduler
  #    - if a :shutdown message is received, exit normally
  #
  def fib(scheduler_pid) do
    send(scheduler_pid, {:ready, self})
    receive do
      {:compute, num, pid} ->
        send(pid, {:result, {num, fib_calc(num)}, self})
        fib(scheduler_pid)
      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end
