module Transactions
  module Domain
    class Transaction
      attr_reader :id, :transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id, :has_cbk

      def initialize(
        id: nil,
        transaction_id:,
        merchant_id:,
        user_id:,
        card_number:,
        transaction_date:,
        transaction_amount:,
        device_id: nil,
        has_cbk: false
      )
        @id = id
        @transaction_id = transaction_id
        @merchant_id = merchant_id
        @user_id = user_id
        @card_number = card_number
        @transaction_date = transaction_date
        @transaction_amount = transaction_amount
        @device_id = device_id
        @has_cbk = has_cbk
      end

      def to_hash
        {
          id: @id,
          transaction_id: @transaction_id,
          merchant_id: @merchant_id,
          user_id: @user_id,
          card_number: @card_number,
          transaction_date: @transaction_date,
          transaction_amount: @transaction_amount,
          device_id: @device_id,
          has_cbk: @has_cbk
        }
      end

      def has_cbk!
        @has_cbk = true
      end
    end
  end
end