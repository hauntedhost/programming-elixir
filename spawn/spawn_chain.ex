defmodule SpawnChain do
  def counter(pid) do
    receive do
      {:count, n} -> send(pid, {:count, n + 1})
    end
  end

  def create_processes(n) do
    # spawn n processes, passing the pid of the previous in as arg to the next
    last_pid = Enum.reduce(1..n, self, fn(_n, pid) ->
      spawn(__MODULE__, :counter, [pid])
    end)

    send(last_pid, {:count, 0})

    receive do
      {:count, final_count} -> "Final count is #{inspect(final_count)}"
    end
  end

  def run(n) do
    IO.puts(inspect :timer.tc(__MODULE__, :create_processes, [n]))
  end
end

# $ time elixir --erl "+P 1000000" -r spawn_chain.ex -e "SpawnChain.run(1_000_000)"
# {10657739, "Final count is 1000000"}
#
# real   	0m11.273s
# user   	0m6.439s
# sys    	0m7.489s
