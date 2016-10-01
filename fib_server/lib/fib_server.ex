defmodule FibServer do
  alias FibServer.{Scheduler, Solver}

  # 1. create a "queue" list of the number 37, 20 times.
  #
  # 2. from 1 to 8, time how long it takes to solve 20 fib sequences up to
  #    the number 37 with with n number of processes computing at once
  #
  def start do
    queue = List.duplicate(37, 20)

    Enum.each(1..8, fn(num_processes) ->
      {time, result} = :timer.tc(
        Scheduler, :run, [num_processes, Solver, :fib, queue]
      )

      # let laptop fan turn off
      Process.sleep(5_000)

      if num_processes == 1 do
        IO.inspect(result)
        IO.puts "\n#\ttime(s)"
      end
      IO.puts "#{num_processes}\t#{time/1000000.0}"
    end)
  end
end
