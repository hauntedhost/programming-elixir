defmodule SpawnReceive do
  def greet do
    receive do
      {sender, message} ->
        send(sender, {:ok, "Hello, #{message}"})
    end
  end
end