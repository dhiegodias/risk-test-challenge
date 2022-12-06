module Transactions
  module Exceptions
    class FraudulentTransactionException < RuntimeError
      def initialize(message: "Transaction denied due to fraud")
        super(message)
      end
    end
  end
end