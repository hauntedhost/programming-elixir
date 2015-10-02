defmodule Sequence.StackServer do
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

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  # GenServer

  def init(_) do
    stack = Sequence.Stash.get(:stack) || []
    {:ok, stack}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :nothing, []}
  end

  def handle_call(:pop, _from, [head|tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, stack) do
    {:noreply, [value|stack]}
  end

  def terminate(_reason, stack) do
    Sequence.Stash.put(:stack, stack)
  end
end
