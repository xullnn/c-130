# def test
#   yield(1, 2)
# end
#
# test { |num, n| puts num, n  }

def test
  yield(1)
end

test { |num, n| p num, n  }
