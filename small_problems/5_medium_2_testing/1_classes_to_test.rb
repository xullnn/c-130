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
end
