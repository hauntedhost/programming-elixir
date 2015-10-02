defmodule Sequence.ParentSupervisor do
  use Supervisor

  ## API

  def start_link(initial_stash \\ %{}) do
    result = {:ok, sup} = Supervisor.start_link(
      __MODULE__, :nothing, name: __MODULE__
    )

    start_workers(sup, initial_stash)
    result
  end

  def start_workers(sup, initial_stash) do
    {:ok, _pid} = Supervisor.start_child(
      sup, worker(Sequence.Stash, [initial_stash])
    )

    {:ok, _pid} = Supervisor.start_child(
      sup, supervisor(Sequence.NumberSupervisor, [])
    )

    {:ok, _pid} = Supervisor.start_child(
      sup, supervisor(Sequence.StackSupervisor, [])
    )
  end

  ## Supervisor

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end