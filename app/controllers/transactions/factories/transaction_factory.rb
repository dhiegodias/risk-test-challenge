module Transactions
  module Factories
    class TransactionFactory
      def self.build
        new(
          transaction_domain: ::Transactions::Domain::Transaction
        )
      end

      def initialize(transaction_domain:)
        @transaction_domain = transaction_domain
      end

      def build_from_hash(transaction_hash)
        @transaction_domain.new(
          transaction_id: transaction_hash[:transaction_id],
          merchant_id: transaction_hash[:merchant_id],
          user_id: transaction_hash[:user_id],
          card_number: transaction_hash[:card_number],
          transaction_date: transaction_hash[:transaction_date],
          transaction_amount: transaction_hash[:transaction_amount],
          device_id: transaction_hash[:device_id]
        )
      end

      def build_from_model(transaction_model)
        @transaction_domain.new(
          id: transaction_model.id,
          transaction_id: transaction_model.transaction_id,
          merchant_id: transaction_model.merchant_id,
          user_id: transaction_model.user_id,
          card_number: transaction_model.card_number,
          transaction_date: transaction_model.transaction_date,
          transaction_amount: transaction_model.transaction_amount,
          device_id: transaction_model.device_id,
          has_cbk: transaction_model.has_cbk
        )
      end
    end
  end
end