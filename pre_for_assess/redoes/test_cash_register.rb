require './cash_register.rb'
require './transaction.rb'
require 'minitest/autorun'

class CashRegisterTest < Minitest::Test
  def setup
    @transaction = Transaction.new(10)
    @register = CashRegister.new(100)
  end

  def test_accept_money
    assert_equal 100, @register.total_money
    @transaction.amount_paid = 20
    @register.accept_money(@transaction)
    assert_equal 120, @register.total_money
  end

  def test_change
    @transaction.amount_paid = 20
    changed = @register.change(@transaction)
    assert_equal 10, changed
  end

  def test_give_receipt
    assert_output("You've paid $10.\n") do
      @register.give_receipt(@transaction)
    end
  end
end
