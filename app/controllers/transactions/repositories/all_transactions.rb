module Transactions
  module Repositories
    class AllTransactions
      def self.build
        new(
          transaction_model: ::Transaction,
          transaction_factory: ::Transactions::Factories::TransactionFactory.build
        )
      end

      def initialize(transaction_model:, transaction_factory:)
        @transaction_model = transaction_model
        @transaction_factory = transaction_factory
      end

      def build_from_hash(transaction_hash)
        transaction_domain = @transaction_factory.build_from_hash(transaction_hash)
        self.save(transaction_domain)
        transaction_domain
      end

      def get_last_transactions_by_user_id(user_id, range)
        transactions = @transaction_model.get_last_transactions(user_id, range)
        transactions.map do |transaction|
          self.build_from_model(transaction)
        end
      end

      def save(transaction_domain)
        transaction_model = @transaction_model.find_or_initialize_by(id: transaction_domain.id)
        transaction_model.transaction_id = transaction_domain.transaction_id
        transaction_model.merchant_id = transaction_domain.merchant_id
        transaction_model.user_id = transaction_domain.user_id
        transaction_model.card_number = transaction_domain.card_number
        transaction_model.transaction_date = transaction_domain.transaction_date
        transaction_model.transaction_amount = transaction_domain.transaction_amount
        transaction_model.device_id = transaction_domain.device_id
        transaction_model.has_cbk = transaction_domain.has_cbk
        transaction_model.save
        transaction_model
      end

      def build_from_model(transaction)
        @transaction_factory.build_from_model(transaction)
      end

      def has_charge_back?(transaction)
        @transaction_model.where(user_id: transaction.user_id, has_cbk: true).present?
      end
    end
  end
end