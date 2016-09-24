defmodule SpawnFailLink do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    # NOTE: You probably don't want to do this. Elixir uses the OTP framework
    # for constructing process trees, and OTP includes the concept of process
    # supervision.
    Process.flag(:trap_exit, true)

    # spawn_link joins the calling process and another process -- each receives
    # notifications about the other.
    spawn_link(__MODULE__, :sad_function, [])
    receive do
      message ->
        IO.puts "Message received: #{inspect message}"
      after 1000 ->
        IO.puts "Nothing happened, as far as I know."
    end
  end
end

# $ elixir -r spawn_fail_link.ex -e SpawnFailLink.run
