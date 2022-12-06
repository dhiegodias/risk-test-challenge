module Transactions
  module Exceptions
    class TooManyTransactionsException < FraudulentTransactionException
      def initialize
        super(message: "Too many transactions")
      end
    end
  end
end