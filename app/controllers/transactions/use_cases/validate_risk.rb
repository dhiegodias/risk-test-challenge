module Transactions
  module UseCases
    class ValidateRisk
      def self.build
        new(
          all_transactions: ::Transactions::Repositories::AllTransactions.build,
          validate_risk_for_transactions_service: ::Transactions::Services::ValidateRiskForTransactions.build
        )
      end

      def initialize(all_transactions:, validate_risk_for_transactions_service:)
        @all_transactions = all_transactions
        @validate_risk_for_transactions_service = validate_risk_for_transactions_service
      end

      def execute(transaction_hash:)
        transaction = @all_transactions.build_from_hash(transaction_hash)
        raise_has_charge_back_exception if @all_transactions.has_charge_back?(transaction)

        @validate_risk_for_transactions_service.validate!(transaction)
        transaction
      rescue ::Transactions::Exceptions::FraudulentTransactionException => exception
        transaction.has_cbk!
        @all_transactions.save(transaction)
        raise exception
      end

      private

      def raise_has_charge_back_exception
        raise ::Transactions::Exceptions::HasChargeBackException.new
      end
    end
  end
end