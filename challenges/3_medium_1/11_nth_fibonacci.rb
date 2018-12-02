class Fibonacci
  def of_nth(the_nth)
    return 1 if the_nth < 3
    pre_fib = 1
    current_fib = 1
    ord_number = 2
    loop do
      return current_fib if ord_number == the_nth
      pre_fib, current_fib = current_fib, (pre_fib + current_fib)
      ord_number += 1
    end
  end
end

p Fibonacci.new.of_nth(1)
p Fibonacci.new.of_nth(3)
p Fibonacci.new.of_nth(7)
p Fibonacci.new.of_nth(20)
