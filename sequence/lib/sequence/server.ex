defmodule Sequence.Server do
  use GenServer

  # API

  def start_link(initial_number \\ 1) do
    GenServer.start_link(__MODULE__, initial_number, name: __MODULE__)
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

  # GenServer

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:inc, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def handle_cast({:set_number, new_number}, _current_number) do
    {:noreply, new_number}
  end
end