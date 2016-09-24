defmodule SpawnReceive do
  def greet do
    receive do
      {sender, message} -> send(sender, {:ok, "Hello, #{message}"})
    end
  end
end

# client
pid = spawn(SpawnReceive, :greet, [])
send(pid, {self, "World!"})

receive do
  {:ok, message} -> IO.puts(message)
end
