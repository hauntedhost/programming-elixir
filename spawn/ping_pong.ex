defmodule PingPong do

  def bounce(:ping), do: bounce({:ping, :pong})
  def bounce(:pong), do: bounce({:pong, :ping})

  def bounce(messages = {my_message, other_message}) do
    receive do
      {^other_message, pid} ->
        IO.puts "received #{other_message}"
        IO.puts "from: #{inspect(pid)}"
        IO.puts "to me: #{inspect(self())}"
        :timer.sleep(3_000)
        IO.puts "sending #{my_message} back\n"
        send(pid, {my_message, self()})
        bounce(messages)
    end
  end
end

ping = spawn(PingPong, :bounce, [:ping])
pong = spawn(PingPong, :bounce, [:pong])
send(pong, {:ping, ping})
