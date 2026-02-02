class Category < ApplicationRecord
  has_many :transactions
  has_one_attached :icon
end
