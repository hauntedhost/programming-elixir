defmodule Ticker.Client do

  @moduledoc """
  Client registers a receiver with Ticker to receive {:tick} messages.

  * `start` spawns a process for :receiver, and registers that pid with Ticker.
  """

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick, index} ->
        IO.puts "tock in client #{index}"
        receiver
    end
  end
end
