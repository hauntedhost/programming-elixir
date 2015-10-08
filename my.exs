defmodule My do

  defmacro if(condition, do: do_clause) do
    My.if(condition, do: do_clause, else: nil)
  end

  defmacro if(condition, do: do_clause, else: else_clause) do
    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _                            -> unquote(do_clause)
      end
    end
  end
end