# PEDAC

  # P
   # handle binary numbers from big to small
    # 10000 doesn't represent any handshake order by as a sign to reverse possible orders
    # then other numbers:
      # 1 = wink
      # 10 = double blink
      # 100 = close your eyes
      # 1000 = jump

    # invalid input should be treated as 0
      # return empty array

    # input: decimal number as integer or binary number's string representation
    # output: string

  # E
    # it has a class SecretHandShake
    # it has an initialize method takes integer or string
    # it has an commands method return the final result

  # D
    # String
    # Array
    # Integer
    # Hash? as lookup table?

  # A
    # take care of the input
      # validate
      # if integer, convert it to binary number
      # if binary string, call to_i

    # store all the messages in an array from wink to jump
    # set rotate = true
    # first divmod number [quotient, remainder]
      # if quotient >= 1 then set rotate = true
    # call digits on N
      # go through digits with index
        # if digit == 1, push messages[index]
    # if rotate reverse array

class SecretHandshake
  MSGS = ['wink', 'double blink', 'close your eyes', 'jump']

  def initialize(number)
    @binary_num = preprocess_number(number)
    @messages = []
  end

  def commands
    inject_msg = (@binary_num / 10000 >= 1) ? :prepend : :push
    (@binary_num % 10000).digits.each_with_index do |digit, index|
      @messages.send(inject_msg, MSGS[index]) if digit == 1
    end
    @messages
  end

  private

  def preprocess_number(number)
    if number.is_a?(Integer) then number.to_s(2).to_i
    elsif number.is_a?(String) && !number.match(/[^01]/) then number.to_i
    else 0
    end
  end
end
