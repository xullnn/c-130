def compute
  return yield if block_given?
  return 'Does not compute.'
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'

def compute(arg)
  return yield(arg) if block_given?
  return 'Does not compute.'
end

p compute(5) { |a| a * 5 }
p compute('s') { |a| a * 5 }
p compute('s')
