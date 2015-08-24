defmodule ParentMonitor do
  import :timer, only: [sleep: 1]

  def notify_parent(parent_pid) do
    send(parent_pid, "Oh, what's up, Mom?")
    raise("hell")
    exit(:peace)
  end

  def receive_messages do
    receive do
      message ->
        IO.puts("Received message: #{inspect(message)}")
      after 1000 ->
        IO.puts("Timeout.")
    end
    receive_messages
  end

  def run do
    spawn_monitor(ParentMonitor, :notify_parent, [self])
    sleep(1000)
    receive_messages
  end
end

# Run:
# $ elixir -r parent_monitor.ex -e ParentMonitor.run
