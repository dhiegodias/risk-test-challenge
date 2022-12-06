module Transactions
  module Exceptions
    class HasChargeBackException < FraudulentTransactionException
      def initialize
        super(message: "Has charge back")
      end
    end
  end
end