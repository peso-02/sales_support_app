class Product < ApplicationRecord
  has_many :product_prices, dependent: :destroy
  has_many :customers, through: :product_prices

  def self.to_csv
    require 'csv'
    
    CSV.generate(headers: true) do |csv|
      csv << [
        "商品コード",
        "商品名",
        "入数",
        "A単価",
        "B単価",
        "C単価",
        "備考"
      ]
      
      all.each do |product|
        csv << [
          product.product_code,
          product.product_name,
          product.case_quantity,
          product.standard_price_a,
          product.standard_price_b,
          product.standard_price_c,
          product.notes
        ]
      end
    end
  end
end
