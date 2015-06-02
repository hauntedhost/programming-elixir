defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true

  def subscribe!(s = %Subscriber{}), do: "#{s.name} subscribed."
  def after_party?(s = %Subscriber{}), do: s.over_18 && s.paid
end
