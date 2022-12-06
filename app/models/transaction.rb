class Transaction < ApplicationRecord
    scope :get_last_transactions, ->(user_id, range) { where(user_id: user_id, transaction_date: range).order(transaction_date: :desc) }
end
