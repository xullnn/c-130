def step(start, ending, stride)
  steps = []
  next_step = start
  until next_step > ending
    yield(next_step)
    steps << (next_step += stride)
  end
  steps
end

step(1, 10, 3) { |value| puts "value = #{value}" }
# value = 1
# value = 4
# value = 7
# value = 10
