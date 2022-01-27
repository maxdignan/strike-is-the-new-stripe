class Business < ApplicationRecord
  has_many :customers
  has_many :invoices
end
