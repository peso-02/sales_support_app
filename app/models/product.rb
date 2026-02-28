class Product < ApplicationRecord
  has_many :product_prices, dependent: :destroy
  has_many :customers, through: :product_prices
end
