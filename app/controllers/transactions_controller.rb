class TransactionsController < ApplicationController
  def top_up
    user = current_user

    # Ensure that the amount is valid
    amount = params[:amount].to_f
    return render_invalid_amount unless amount > 0

    # Attempt to create the credit transaction
    success, message = create_credit_transaction(user, amount)
    if success
      render json: { 
        status: 'success', 
        message: 'Top-up successful', 
        new_balance: user.balance 
      }, status: :ok
    else
      render json: { 
        status: 'error', 
        message: message
      }, status: :unprocessable_entity
    end
  end

  private

  def create_credit_transaction(user, amount)
    success = false
    error_message = "Failed to top-up."

    ActiveRecord::Base.transaction do
      transaction_group = TransactionGroup.create!(description: 'Top-up')
      
      transaction = Credit.new(
        amount: amount, 
        user: user, 
        transaction_group: transaction_group
      )

      if transaction.save
        success = true
      else
        error_message = transaction.errors.full_messages.join(', ')
        Rails.logger.debug "This is a debug message"
        raise ActiveRecord::Rollback
      end
    end

    [success, error_message]
  end

  def render_invalid_amount
    render json: { 
      status: 'error', 
      message: 'Invalid amount specified.' 
    }, status: :bad_request
  end
end
