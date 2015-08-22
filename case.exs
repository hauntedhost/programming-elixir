defmodule Case do

  @sean %{name: "Sean", age: 39}

  def check_id(person \\ @sean) do
    case person do
      %{age: age} when is_number(age) and age >= 21 ->
        IO.puts "Welcome. You can enter the bar, #{person.name}."
      _ ->
        IO.puts "Sorry #{person.name}, you must be 21 or older to enter."
    end
  end

  def ok!(response) do
    case response do
      {:ok, data} ->
        data
      {:error, reason} ->
        raise RuntimeError, message: to_string(reason)
    end
  end

  def open_file!(filename \\ "cats.txt") do
    ok! File.open(filename)
  end

  def open_file(filename \\ "cats.txt") do
    case File.open(filename) do
      {:ok, file} ->
        line = String.rstrip(IO.read(file, :line), ?\n)
        IO.puts "First line: #{line}"
      {:error, reason} ->
        IO.puts "Failed to open file: #{reason}"
    end
  end
end
