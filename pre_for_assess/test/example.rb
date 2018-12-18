def update_data(select_string)
  data = fetch(select_string)
  data.each { |x| yield(x) }
  save(data)
end

def update_by_type(type, &block) # you can update this method
  update_data("employee_type = #{type}", &block)
end

def update_by_location(location, &block) # you can update this method
  update_data("employee_location = #{location}", &block)
end

# Example calls - do not modify these lines
update_by_type("Manager") do |employee|
  employee.salary *= 1.25
end

update_by_location("Oregon") do |employee|
  employee.salary *= 1.10
end


def a_method(str)
  puts str
  yield if block_given?
end

def method_two(str, &block)
  a_method(str, &block)
end

method_two("something") { puts "hello" }
