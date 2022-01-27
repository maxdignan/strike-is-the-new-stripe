class Customer < ApplicationRecord
  belongs_to :business

  has_many :invoices
end
