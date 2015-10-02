defmodule Sequence.ParentSupervisor do
  use Supervisor

  def start_link(initial_number \\ 1) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_number])
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    {:ok, stash} =
      Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
    Supervisor.start_child(sup, supervisor(Sequence.ChildSupervisor, [stash]))
  end

  def init(_) do
    supervise([], strategy: :one_for_one)
  end
end