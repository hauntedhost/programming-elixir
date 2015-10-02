defmodule Sequence.NumberServer do
  use GenServer

  ## API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def inc(delta \\ 1) do
    GenServer.cast(__MODULE__, {:inc, delta})
  end

  def next do
    GenServer.call(__MODULE__, :next_number)
  end

  def set(new_number) do
    GenServer.cast(__MODULE__, {:set_number, new_number})
  end

  ## GenServer

  def init(stash_pid) do
    current_number = Sequence.Stash.get(:number)
    {:ok, {current_number, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    {:reply, current_number, {current_number + 1, stash_pid}}
  end

  def handle_cast({:inc, delta}, {current_number, stash_pid}) do
    {:noreply, {current_number + delta, stash_pid}}
  end

  def handle_cast({:set_number, new_number}, {_current_number, stash_pid}) do
    {:noreply, {new_number, stash_pid}}
  end

  def terminate(_reason, {current_number, stash_pid}) do
    Sequence.Stash.put(:number, current_number)
  end
end