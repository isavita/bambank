require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipient) { FactoryBot.create(:user) }

  describe 'POST #create' do
    before do
      sign_in user
    end

    context 'when the user does not have an account' do
      it 'redirects to the root path' do
        user.account.delete
        post :create, params: { transaction: { amount: 1, recipient_id: recipient.id } }
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq("You must have an account to send money.")
      end
    end

    context 'when the recipient does not exist' do
      it 'redirects to the user account path' do
        post :create, params: { transaction: { amount: 1, recipient_id: 123456 } }
        expect(response).to redirect_to(account_path(user.account, status: :unprocessable_entity))
        expect(flash[:error]).to eq("Recipient does not exist or does not have an account.")
      end
    end

    context 'when the amount is less than or equal to 0' do
      it 'redirects to the user account path' do
        post :create, params: { transaction: { amount: 0, recipient_id: recipient.id } }
        expect(response).to redirect_to(account_path(user.account, status: :unprocessable_entity))
        expect(flash[:error]).to eq("You must send a positive amount.")
      end
    end

    context 'when the user balance is less than the amount' do
      it 'redirects to the user account path' do
        post :create, params: { transaction: { amount: user.account.balance + 1, recipient_id: recipient.id } }
        expect(response).to redirect_to(account_path(user.account, status: :unprocessable_entity))
        expect(flash[:error]).to eq("You do not have enough balance to complete this transaction.")
      end
    end

    context 'when the transaction is successful' do
      it 'redirects to the user account path' do
        user_balance = user.account.balance
        recipient_balance = recipient.account.balance
        
        post :create, params: { transaction: { amount: 1, recipient_id: recipient.id } }
        expect(response).to redirect_to(account_path(user.account))
        expect(flash[:notice]).to eq("Transaction successful!")
        expect(user.account.reload.balance).to eq(user_balance - 1)
        expect(recipient.account.reload.balance).to eq(recipient_balance + 1)
      end
    end
  end
end
