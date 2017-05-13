defmodule Howdy.Counter do
  use GenServer

  # Public API

  def start_link(server_name, count \\ 0) do
    GenServer.start_link(__MODULE__, count, name: server_name)
  end

  def inc(server_name) do
    GenServer.call(server_name, :inc)
  end

  def dec(server_name) do
    GenServer.call(server_name, :dec)
  end

  # GenServer API

  def handle_call(:inc, _from, state) do
    {:reply, state + 1, state + 1}
  end

  def handle_call(:dec, _from, state) do
    {:reply, state - 1, state - 1}
  end
end
