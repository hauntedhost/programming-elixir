defmodule TickerClient do
  require TickerServer

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    TickerServer.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock!")
        receiver
    end
  end
end
