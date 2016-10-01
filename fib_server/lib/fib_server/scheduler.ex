defmodule FibServer.Scheduler do

  # 1. spawns a list of solver processes
  #
  # 2. each solver process immediately sends a {:ready, self} message back to us
  #
  # 3. wait for message
  #    - if receive gets :ready message from a solver, and there are still computations left
  #      it sends the next item on the queue to the solver, and recurses with remaining
  #    - if receive gets :ready message from a solver, but there are no computations left
  #      it sends a :shutdown to the solver, and removes that solver pid from it's list of
  #      processes. if this is the last process, return sorted results, otherwise recurse
  #    - if it receives a :result message from a solver, add that result to results
  #      and recurse.
  #
  def run(num_processes, module, func, queue) do
    num_processes
    |> spawn_computation_processes(module, func)
    |> schedule_computations(queue, [])
  end

  defp spawn_computation_processes(num_processes, module, func) do
    Enum.map(1..num_processes, fn(_) ->
      spawn(module, func, [self])
    end)
  end

  # processes is a list of pids to spawned solver processes
  defp schedule_computations(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | remaining] = queue
        send(pid, {:compute, next, self})
        schedule_computations(processes, remaining, results)
      {:ready, pid} ->
        send(pid, {:shutdown})
        if length(processes) > 1 do
          processes
          |> List.delete(pid)
          |> schedule_computations(queue, results)
        else
          Enum.sort(results, fn({n1, _}, {n2, _}) -> n1 <= n2 end)
        end
      {:result, {order_by_num, result}, _pid} ->
        schedule_computations(processes, queue, [{order_by_num, result} | results])
    end
  end
end
