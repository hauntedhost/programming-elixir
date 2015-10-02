defmodule Sequence do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = Sequence.ParentSupervisor.start_link(123)
  end
end