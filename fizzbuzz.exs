fizzbuzz = fn
  (0, 0, _) -> "fizzbuzz"
  (0, _, _) -> "fizz"
  (_, 0, _) -> "buzz"
  (_, _, c) -> c
end

fb = fn (n) ->
  fizzbuzz.(rem(n, 3), rem(n, 5), n)
end
