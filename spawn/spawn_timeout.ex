defmodule SpawnTimeout do
  def greet do
    receive do
      {sender, message} -> send(sender, {:ok, "Hello, #{message}"})
    end
  end
end

# client
pid = spawn(SpawnTimeout, :greet, [])

send(pid, {self, "World!"})
receive do
  {:ok, message} -> IO.puts(message)
end

send(pid, {self, "Sean"})
receive do
  {:ok, message} -> IO.puts message
  after 500      -> IO.puts "The greeter has gone away"
end
