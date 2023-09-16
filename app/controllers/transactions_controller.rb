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

  def transfer
    sender = current_user
    recipient = User.find_by(account_no: params[:account_no])
  
    unless recipient
      render json: { status: 'error', message: 'Recipient not found' }, status: :not_found and return
    end

    if sender == recipient
      render json: { status: 'error', message: 'You cannot transfer to your own account' }, status: :unprocessable_entity and return
    end
  
    amount = params[:amount].to_f
    if amount <= 0
      render json: { status: 'error', message: 'Invalid transfer amount' }, status: :bad_request and return
    end
  
    if sender.balance < amount
      render json: { status: 'error', message: 'Insufficient balance' }, status: :unprocessable_entity and return
    end
  
    # Start the transaction block
    ActiveRecord::Base.transaction do
      transaction_group = TransactionGroup.create!(description: 'Transfer to ' + recipient.account_no + ".#{params[:description]}")
      
      # Debit the sender
      Debit.create!(
        user: sender,
        amount: amount, 
        transaction_group: transaction_group,
      )
  
      # Credit the recipient
      Credit.create!(
        user: recipient,
        amount: amount, 
        transaction_group: transaction_group,
      )
    end
  
    render json: { 
      status: 'success', 
      message: 'Transfer successful',
      new_balance: sender.balance
    }, status: :ok
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
