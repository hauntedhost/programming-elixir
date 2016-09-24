defmodule SpawnFail do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn(__MODULE__, :sad_function, [])
    receive do
      message ->
        IO.puts "Message received: #{inspect message}"
      after 1000 ->
        IO.puts "Nothing happened, as far as I know."
    end
  end
end

# $ elixir -r spawn_fail.ex -e SpawnFail.run
