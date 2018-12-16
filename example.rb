# require 'pry'
#
# a = 1
# b = 2
#
# def method_one
#   puts "Hello."
# end
#
# binding.pry
#
# c = 3
#
# def method_two
#   puts "Goodbye!"
# end

# def url?(string)
#   puts !!(string =~ /^https*:\/\/\S+$/)
# end
#
# url?('http://launchschool.com')   # -> true
# url?('https://example.com')       # -> true
# url?('https://example.com hello') # -> false
# url?('   https://example.com')    # -> false

# def fields(string)
#   p string.split(/[^\w]+/)
# end
#
# fields("Pete,201,Student")
# # -> ['Pete', '201', 'Student']
#
# fields("Pete \t 201    ,  TA")
# # -> ['Pete', '201', 'TA']
#
# fields("Pete \t 201")
# # -> ['Pete', '201']

# def mystery_math(string)
#   p string.sub(/[\+\-\/\*]/, '?')
# end
#
# mystery_math('4 + 3 - 5 = 2')
# # -> '4 ? 3 - 5 = 2'
#
# mystery_math('(4 * 3 + 2) / 7 - 1 = 1')
# # -> '(4 ? 3 + 2) / 7 - 1 = 1'

# def danish(string)
#   p string.sub(/\b(apple|blueberry|cherry)\b/, 'danish')
# end
#
# danish('An apple a day keeps the doctor away')
# # -> 'An danish a day keeps the doctor away'
#
# danish('My favorite is blueberry pie')
# # -> 'My favorite is danish pie'
#
# danish('The cherry of my eye')
# # -> 'The danish of my eye'
#
# danish('apple. cherry. blueberry.')
# # -> 'danish. cherry. blueberry.'
#
# danish('I love pineapple')
# # -> 'I love pineapple'

# def format_date(date_str)
#   p date_str.sub(/(\d{4})([\-\/])(\d{2})\2(\d{2})/, '\4.\3.\1')
# end
#
# format_date('2016-06-17') # -> '17.06.2016'
# format_date('2017/05/03') # -> '03.05.2017'
# format_date('2015/01-31') # -> '2015/01-31' (no change)
