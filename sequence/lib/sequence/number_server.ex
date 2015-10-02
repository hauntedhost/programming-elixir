defmodule Sequence.NumberServer do
  use GenServer

  ## API

  def start_link do
    {:ok, _pid} = GenServer.start_link(
      __MODULE__, :nothing, name: __MODULE__
    )
  end

  def crash! do
    GenServer.call(__MODULE__, :crash!)
  end

  def inc(delta \\ 1) do
    GenServer.cast(__MODULE__, {:inc, delta})
  end

  def next do
    GenServer.call(__MODULE__, :next)
  end

  def set(new_number) do
    GenServer.cast(__MODULE__, {:set, new_number})
  end

  ## GenServer

  def init(_) do
    current_number = Sequence.Stash.get(:number) || 0
    {:ok, current_number}
  end

  def handle_call(:next, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:inc, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def handle_cast({:set, new_number}, _current_number) do
    {:noreply, new_number}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.put(:number, current_number)
  end
end