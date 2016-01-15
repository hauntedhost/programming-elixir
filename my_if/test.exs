defmodule Test do
  require My
  My.if 1 == 2 do
    IO.puts "1 == 2"
  else
    IO.puts "1 != 2"
  end
end
