class TransactionsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      # Ensure the current user has an account
      unless current_user.account
        flash[:error] = "You must have an account to send money."
        redirect_to root_path
        return
      end
  
      # Check if the recipient exists and has an account
      recipient = User.find_by_id(transaction_params[:recipient_id])
      unless recipient && recipient.account
        flash[:error] = "Recipient does not exist or does not have an account."
        redirect_to account_path(current_user.account, status: :unprocessable_entity)

        return
      end
  
      amount = transaction_params[:amount].to_i
      # Check if the current user has enough balance
      if amount <= 0
        flash[:error] = "You must send a positive amount."
        redirect_to account_path(current_user.account, status: :unprocessable_entity)
        return
      end

      if current_user.account.balance < amount
        flash[:error] = "You do not have enough balance to complete this transaction."
        redirect_to account_path(current_user.account, status: :unprocessable_entity)
        return
      end
  
      # Create the transaction and update account balances
      ActiveRecord::Base.transaction do
        @transaction = Transaction.new(transaction_params)
        @transaction.sender_id = current_user.id
        @transaction.sender_account = current_user.account
        @transaction.recipient_account = recipient.account

        if @transaction.save
          current_user.account.update(balance: current_user.account.balance - amount)
          recipient.account.update(balance: recipient.account.balance + amount)
          flash[:notice] = "Transaction successful!"
          redirect_to account_path(current_user.account)
        else
          flash[:error] = @transaction.errors.full_messages.to_sentence
          redirect_to account_path(current_user.account, status: :unprocessable_entity)
        end
      end
    end
  
    private
  
    def transaction_params
      params.require(:transaction).permit(:amount, :recipient_id)
    end
  end
  