module Transactions
  module Services
    class ValidateRiskForTransactions
      def self.build
        new(all_transactions: ::Transactions::Repositories::AllTransactions.build)
      end

      def initialize(all_transactions:)
        @all_transactions = all_transactions
      end

      def validate!(transaction)
        raise_amount_and_time_restriction_exception if max_authorized_amount_reached?(transaction)
        raise_too_many_transactions_exception if more_than_three_transactions_in_three_minutes?(transaction)
      end

      private

      def max_authorized_amount_reached?(new_transaction)
        today = (DateTime.current.beginning_of_day)..(DateTime.current.end_of_day)
        today_transactions = @all_transactions.get_last_transactions_by_user_id(new_transaction.user_id, today)
        total_amount_of_today_transactions = today_transactions.sum(0){ |transaction| transaction.transaction_amount }
        new_transaction.transaction_amount > 1000 || total_amount_of_today_transactions > 2500
      end

      def raise_amount_and_time_restriction_exception
        raise ::Transactions::Exceptions::AmountAndTimeRestrictionException.new
      end

      def more_than_three_transactions_in_three_minutes?(transaction)
        valid_transaction_time_range = (DateTime.current - 3.minutes)..DateTime.current
        last_transactions = @all_transactions.get_last_transactions_by_user_id(transaction.user_id, valid_transaction_time_range)
        last_transactions.count > 3
      end

      def raise_too_many_transactions_exception
        raise ::Transactions::Exceptions::TooManyTransactionsException.new
      end
    end
  end
end