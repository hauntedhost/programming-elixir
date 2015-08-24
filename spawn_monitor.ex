defmodule SpawnMonitor do
  import :timer, only: [sleep: 1]

  def happy_cat do
    sleep(500)
    exit(:meow)
  end

  def run do
    res = spawn_monitor(SpawnMonitor, :happy_cat, [])
    IO.puts(inspect(res))
    receive do
      message ->
        IO.puts("Message received: #{inspect(message)}")
      after 1000 ->
        IO.puts "Nothing happened, as far as I know."
    end
  end
end

# Run:
# $ elixir -r spawn_monitor.ex -e SpawnMonitor.run
