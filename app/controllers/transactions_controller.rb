class TransactionsController < ApplicationController
  def create
    use_case = ::Transactions::UseCases::ValidateRisk.build
    use_case.execute(transaction_hash: transaction_params)
    render json: { "transaction_id": transaction_id, "recommendation": "approve" }, status: :created
  rescue ::Transactions::Exceptions::FraudulentTransactionException => exception
    render json: { "transaction_id": transaction_id, "recommendation": "deny" }, status: :bad_request
  end

  private

  def transaction_params
    params.permit(:transaction_id, :merchant_id, :user_id, :card_number, :transaction_date, :transaction_amount, :device_id)
  end

  def transaction_id
    transaction_params[:transaction_id]
  end
end