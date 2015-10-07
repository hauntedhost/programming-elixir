defmodule Sequence do
  use Application

  def start(_type, _args) do
    initial_stash = Application.get_env(:sequence, :initial_stash)
    {:ok, _pid} = Sequence.ParentSupervisor.start_link(initial_stash)
  end
end