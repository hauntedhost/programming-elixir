prefix = fn (prefix) ->
  fn (name) ->
    "#{prefix} #{name}"
  end
end

