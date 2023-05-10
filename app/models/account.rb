class Account < ApplicationRecord
  belongs_to :user
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'sender_account_id'
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'recipient_account_id'
end
