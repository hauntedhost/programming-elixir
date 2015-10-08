defmodule Anagrams.Dictionary do
  @name {:global, __MODULE__}

  ## API

  def start_link do
    Agent.start_link(fn -> HashDict.new end, name: @name)
  end

  def add_words(words) do
    Agent.update(@name, &add_words(&1, words))
  end

  def anagrams_of(word) do
    Agent.get(@name, &Dict.get(&1, signature_of(word)))
  end

  def seed_words(range \\ 1..4) do
    Enum.map(range, &"words/list#{&1}.txt") |> Anagrams.WordLoader.from_files
  end

  ## Internal

  defp add_words(dict, words) do
    words |> Enum.reduce(dict, &add_word(&2, &1))
  end

  defp add_word(dict, word) do
    Dict.update(dict, signature_of(word), [word], &[word|&1])
  end

  defp signature_of(word) do
    word |> to_char_list |> Enum.sort |> to_string
  end
end