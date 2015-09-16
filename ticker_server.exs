defmodule TickerServer do
  @name :ticker
  @interval 2000

  def start do
    case global_pid do
      :undefined ->
        pid = spawn(__MODULE__, :generator, [[]])
        :global.register_name(@name, pid)
        {:ok, pid}
      pid ->
        {:ok, pid}
    end
  end

  def register(client_pid) do
    case global_pid do
      :undefined ->
        {:error, "Server not started!"}
      pid ->
        send(pid, {:register, client_pid})
    end
  end

  def generator(client_pids) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        generator([pid|client_pids])
      after
        @interval ->
          IO.puts("tick")
          Enum.each(client_pids, fn(pid) ->
            IO.puts("sending tick to #{inspect(pid)}")
            send(pid, {:tick})
          end)
          generator(client_pids)
    end
  end

  defp global_pid do
    :global.whereis_name(@name)
  end

  # defp module_name do
  #   IO.puts(__MODULE__)
  # end
end
