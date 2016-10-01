defmodule Ticker do

  @moduledoc """
  Ticker sends registered clients a {:tick, client_index} message very @interval.

  * `start` spawns a process for :generator, initialized with an empty map, then
  globally registers this process as @name.

  * `register` takes a pid and sends a message to the :generator, to add this pid to
  its map of client pids. (A map is used to prevent clients from registering more
  than once).
  """

  @interval 2_000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [%{}])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(ticker_pid, {:register, client_pid})
  end

  def generator(client_pids) do
    receive do
      {:register, client_pid} ->
        IO.puts "register #{inspect(client_pid)}"
        client_pids
        |> Map.put_new(client_pid, Enum.count(client_pids) + 1)
        |> generator
      after
        @interval ->
          client_pids
          |> Enum.each(fn({client_pid, client_index}) ->
            send(client_pid, {:tick, client_index})
          end)
          generator(client_pids)
    end
  end

  def ticker_pid do
    :global.whereis_name(@name)
  end
end
