# defmodule Chop do
#   def guess(answer, answer.._), do: answer

#   def guess(answer, _..answer), do: answer

#   def guess(answer, low..high) do
#     middle = div(low + high, 2)
#     IO.puts "Hmm, is it #{middle}?"
#     if answer > middle do
#       guess(answer, middle..high)
#     else
#       guess(answer, low..middle)
#     end
#   end
# end

defmodule Guess do
  def play(answer, range = low..high) do
    guess = div(low + high, 2)
    IO.puts("Hmm, is it #{guess}?")
    _play(answer, guess, range)
  end

  defp _play(answer, answer, _),
    do: IO.puts "Yep! It's #{answer}!"

  defp _play(answer, guess,  _low..high) when guess < answer,
    do: play(answer, (guess + 1)..high)

  defp _play(answer, guess,  low.._high) when guess > answer,
    do: play(answer, low..(guess - 1))
end

# iex(15)> Guess.play(3, 1..100000)
# Hmm, is it 50000?
# Hmm, is it 25000?
# Hmm, is it 12500?
# Hmm, is it 6250?
# Hmm, is it 3125?
# Hmm, is it 1562?
# Hmm, is it 781?
# Hmm, is it 390?
# Hmm, is it 195?
# Hmm, is it 97?
# Hmm, is it 48?
# Hmm, is it 24?
# Hmm, is it 12?
# Hmm, is it 6?
# Hmm, is it 3?
# Yep! It's 3!
# 3

# defmodule Chop do
#   def guess(actual, actual.._), do: actual
#   def guess(actual, _..actual), do: actual
#   def guess(actual, low..high) do
#     midpoint = low + div(high - low, 2)
#     IO.puts "Is it #{midpoint}?"
#     if actual < midpoint do
#       guess actual, low..midpoint
#     else
#       guess actual, midpoint..high
#     end
#   end
# end

# defmodule Chop do
#   def guess(actual, range = low..high) do
#     guess = div(low+high, 2)
#     IO.puts "Is it #{guess}?"
#     _guess(actual, guess, range)
#   end

#   defp _guess(actual, actual, _),
#     do: IO.puts "Yes, it's #{actual}"

#   defp _guess(actual, guess,  _low..high)
#     when guess < actual,
#     do: guess(actual, guess+1..high)

#   defp _guess(actual, guess,  low.._high)
#     when guess > actual,
#     do: guess(actual, low..guess-1)
# end

# Chop.guess(273, 1..1000)
