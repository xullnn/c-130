# # Group 1
# my_proc = proc { |thing| puts "This is a #{thing}." }
# puts my_proc
# puts my_proc.class
# my_proc.call
# my_proc.call('cat')

# we can define a proc object by giving a block
# we can execute the code in the block by calling `.call` method on proc object
  # while we are calling a proc
    # the argument(s) that are passed in could be captured by block parameter
    # if we didn't give any argument while calling a proc, the extra block parameter in the block will be evaluated to `nil`

# # Group 2
# my_lambda = lambda { |thing| puts "This is a #{thing}." }
# my_second_lambda = -> (thing) { puts "This is a #{thing}." }
# puts my_lambda
# puts my_second_lambda
# puts my_lambda.class
# my_lambda.call('dog')
# my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# we can define a lambda by using similar syntax as creating a proc, only change `proc` to `lambda`
# there's is another syntax to create a lambda, this syntax move out the block parameter out of the block and wrap it by parentheses
# although we use `lambda` syntax to create a lambda, when we print out the string representation of a lambda we can see that it also is a Proc object
# calling a lambda must pass the right number of arguments, or it will raise argument error
# a lamdba is also a Proc object
# since there is no Lambda class, we cannot use syntax like `Lambda.new` to creat a new lambda

# # Group 3
# def block_method_1(animal)
#   yield
# end
#
# block_method_1('seal') { |seal| puts "This is a #{seal}."}
# block_method_1('seal')

# if we use `yield` in a method definition without specifying any condition, we must give a block while calling this method
# `yield` in a method only execute the code in the block which jus passed in, if we didn't specify arguments for `yield`
  # no argument will be pass in the block, nor we can capture arguments by block parameters
  # meaningless block parameters will not cause error, they will be evaluated to `nil`
  # so block has a very loose rule towards verifying the number of arguments

# Group 4
# def block_method_2(animal)
#   yield(animal)
# end
#
# block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
# block_method_2('turtle') do |turtle, seal|
#   puts "This is a #{turtle} and a #{seal}."
# end
# block_method_2('turtle') { puts "This is a #{animal}."}

# we can pass arguments that are been passed in a method to the block by writing them after `yield` keyword
# we capture the arguments passed to a block by using block parameter
  # if the number of block parameters are more than arguments that are been passed in
    # the excessive block parameters will be evaluated to `nil`
# if we explicitly specify arguments for `yiled` and we don't give any while calling this method, it will raise exception
