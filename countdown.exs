defmodule Countdown do
  # def sleep(seconds) do
  #   receive do
  #     after seconds * 1000 -> nil
  #   end
  # end

  def sleep do
    _sleep(current_second, 0) # 5
  end

  defp _sleep(initial_second, ticks) do
    if current_second <= initial_second do
      _sleep(initial_second, ticks + 1)
    else
      {:ok, ticks}
    end
  end

  def current_second do
    {_h, _m, second} = :erlang.time
    second
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    Stream.resource(
      fn ->
        {_h, _m, s} = :erlang.time
        60 - s - 1
      end,

      fn
        0     ->
          {:halt, 0}
        count ->
          IO.inspect sleep
          {[inspect(count)], count - 1}
      end,

      fn _ -> end
    )
  end

  def start do
    timer
    |> Stream.each(&IO.puts/1)
    |> Stream.each(&Countdown.say/1)
    |> Enum.to_list
  end
end
