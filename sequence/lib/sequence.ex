defmodule Sequence do
  use Application

  def start(_type, args) do
    {:ok, _pid} = Sequence.ParentSupervisor.start_link(args)
  end
end