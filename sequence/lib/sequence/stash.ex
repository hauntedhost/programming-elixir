defmodule Sequence.Stash do
  use GenServer

  ## API

  def start_link(stash \\ %{}) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash, name: __MODULE__)
  end

  def put(key, val) do
    GenServer.cast(__MODULE__, {:put, {key, val}})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  ## GenServer

  def handle_call({:get, key}, _from, current_stash) do
    {:reply, Map.get(current_stash, key), current_stash}
  end

  def handle_cast({:put, {key, val}}, current_stash) do
    {:noreply, Map.put(current_stash, key, val)}
  end
end