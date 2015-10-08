defmodule Sequence.NumberServer do
  use GenServer
  require Logger

  @vsn "1"

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
    number = Sequence.Stash.get(:number) || 0
    {:ok, %{number: number, delta: 1}}
  end

  def handle_call(:next, _from, state) do
    {:reply, state.number, %{state | number: state.number + state.delta}}
  end

  def handle_cast({:inc, delta}, state) do
    {:noreply, %{number: state.number + delta, delta: delta}}
  end

  def handle_cast({:set, new_number}, state) do
    {:noreply, %{state | number: new_number}}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.put(:number, current_number)
  end

  def code_change("0", old_state, _extra) do
    new_state = %{number: old_state, delta: 1}
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    {:ok, new_state}
  end
end