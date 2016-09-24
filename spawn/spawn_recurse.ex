defmodule SpawnRecurse do
  def greet do
    receive do
      {sender, message} -> send(sender, {:ok, "Hello, #{message}"})
    end
    greet
  end
end

# client
pid = spawn(SpawnRecurse, :greet, [])

send(pid, {self, "World!"})
receive do
  {:ok, message} -> IO.puts(message)
end

send(pid, {self, "Sean"})
receive do
  {:ok, message} -> IO.puts(message)
end
