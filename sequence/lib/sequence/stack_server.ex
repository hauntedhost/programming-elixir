defmodule Sequence.StackServer do
  use GenServer

  # API

  def start_link(initial_stack \\ []) do
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  # GenServer

  # def handle_call(:pop, _from, []) do
  #   {:reply, :nothing, []}
  # end

  def handle_call(:pop, _from, [x|xs]) do
    {:reply, x, xs}
  end

  def handle_cast({:push, x}, xs) do
    {:noreply, [x|xs]}
  end
end
