require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'cash_register'
require_relative 'transaction'

Minitest::Reporters.use!

class CashRegisterTest < Minitest::Test
  # need a Transaction object to be passed in
  def setup
    @cash_register = CashRegister.new(0)
    @valid_transaction = Transaction.new(100)
  end

  def test_accept_money
    pre_total_money = @cash_register.total_money
    @valid_transaction.amount_paid = 100
    @cash_register.accept_money(@valid_transaction)
    assert_equal(pre_total_money + 100, @cash_register.total_money)
  end

  def test_change_method
    pre_total_money = @cash_register.total_money
    @valid_transaction.amount_paid = 120
    change = @cash_register.change(@valid_transaction)
    assert_equal(20, change)
  end

  def test_give_receipt
    assert_output("You've paid $100.\n") do
      @cash_register.give_receipt(@valid_transaction)
    end
  end

  # if the output message is very long and we know the key message that we want to match
  # def test_give_receipt
  #   assert_output(/paid \$100/) do
  #     @cash_register.give_receipt(@valid_transaction)
  #   end
  # end
end
