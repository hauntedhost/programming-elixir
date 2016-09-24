defmodule SpawnMonitor do
  import :timer, only: [sleep: 1]

  def happy_cat do
    sleep(500)
    exit(:meow)
  end

  def run do
    # spawn_link` joins the calling process and another process -- each receives
    # notifications about the other. By contrast, spawn_monitor lets a process
    # spawn another and be notified of its termination, but without the reverse
    # notification -- it is one-way only.
    res = spawn_monitor(__MODULE__, :happy_cat, [])
    IO.inspect(res)
    receive do
      message ->
        IO.puts "Message received: #{inspect(message)}"
      after 1000 ->
        IO.puts "Nothing happened, as far as I know."
    end
  end
end

# $ elixir -r spawn_monitor.ex -e SpawnMonitor.run
