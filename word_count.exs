defmodule WordCount do

  def start_link do
    Agent.start(fn -> HashDict.new end, name: __MODULE__)
  end

  def add_word(word) do
    Agent.update(__MODULE__, fn(dict) ->
      Dict.update(dict, word, 1, &(&1 + 1))
    end)
  end

  def count_for(word) do
    Agent.get(__MODULE__, fn(dict) ->
      Dict.get(dict, word)
    end) || 0
  end

  def words do
    Agent.get(__MODULE__, fn(dict) ->
      Dict.keys(dict)
    end)
  end
end