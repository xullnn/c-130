def a_method(array)
  yield array
end

a_method { |_, _, *raptors| }
