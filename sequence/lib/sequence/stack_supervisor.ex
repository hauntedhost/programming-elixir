defmodule Sequence.StackSupervisor do
  use Supervisor

  ## API

  def start_link do
    {:ok, _pid} = Supervisor.start_link(
      __MODULE__, :nothing, name: __MODULE__
    )
  end

  ## Supervisor

  def init(_) do
    child_processes = [worker(Sequence.StackServer, [])]
    supervise(child_processes, strategy: :one_for_one)
  end
end