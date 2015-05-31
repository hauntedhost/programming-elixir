Convert a float to a string with two decimal digits. (Erlang)
`:erlang.float_to_list(7.12, [{:decimals, 4}, :compact])`

Get the value of an operating-system environment variable. (Elixir)
`System.get_env("PATH")`

Return the extension component of a file name (so return .exs if given
"dave/test.exs"). (Elixir)
`Path.extname("~/code/elixir/programming-elixir/factorial.exs")`

Return the process's current working directory. (Elixir)
`System.cwd`

Convert a string containing JSON into Elixir data structures. (Just
find; don't install.)
https://github.com/devinus/poison
https://github.com/cblage/elixir-json
etc.

Execute a command in your operating system's shell.
`System.cmd("ls", ["-hal"]) |> elem(0) |> String.split("\n")`
