require 'minitest/autorun'
require './transaction.rb'
require './cash_register.rb'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(10)
    mock_io = StringIO.new("20\n")
    assert_output("You owe $#{transaction.item_cost}.\nHow much are you paying?\n") do
      transaction.prompt_for_payment(input: mock_io)
    end
    assert_equal 20, transaction.amount_paid
  end
end
