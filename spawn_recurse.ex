defmodule SpawnRecurse do
  def greet(last_message \\ nil) do
    receive do
      {sender, message} ->
        if last_message do
          send(sender, {:ok,
            "Hello, #{message}. (Last message was #{last_message})."
          })
        else
          send(sender, {:ok, "Hello, #{message}"})
        end
        greet(message)
    end
  end
end