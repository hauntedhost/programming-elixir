defmodule Ticker do
  @interval 2000 # 2 seconds
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def generator(client_pids) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        generator([pid|client_pids])
      after @interval ->
        IO.puts("tick")
        Enum.each(client_pids, fn(client_pid) ->
          send(client_pid, {:tick})
        end)
        generator(client_pids)
    end
  end
end