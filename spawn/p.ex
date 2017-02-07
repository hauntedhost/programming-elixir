defmodule P do
  def map(list, fun) do
    me = self()
    list
    |> Enum.map(fn(item) ->
      spawn_link(fn -> send(me, {self(), fun.(item)}) end)
    end)
    |> Enum.map(fn(pid) ->
      receive do
        {^pid, result} -> result
      end
    end)
  end
end
