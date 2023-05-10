class Transaction < ApplicationRecord
  belongs_to :sender_account, class_name: 'Account'
  belongs_to :recipient_account, class_name: 'Account'
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
