module Transactions
  module Exceptions
    class AmountAndTimeRestrictionException < FraudulentTransactionException
      def initialize
        super(message: "Not allowed to make transactions with this amount and time")
      end
    end
  end
end