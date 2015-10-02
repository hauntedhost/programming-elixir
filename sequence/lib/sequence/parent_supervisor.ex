defmodule Sequence.ParentSupervisor do
  use Supervisor

  def start_link(initial_number \\ 1) do
    result = {:ok, sup} = Supervisor.start_link(
      __MODULE__, [initial_number], name: __MODULE__
    )

    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    {:ok, stash_pid} = Supervisor.start_child(
      sup, worker(Sequence.Stash, [%{number: initial_number}])
    )

    {:ok, _pid} = Supervisor.start_child(
      sup, supervisor(Sequence.NumberSupervisor, [stash_pid])
    )
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end