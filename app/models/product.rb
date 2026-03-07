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

  def self.import(file)
    require 'csv'
    
    # 必須ヘッダーのチェック
    required_headers = ["商品コード", "商品名", "入数", "A単価", "B単価", "C単価", "備考"]
    csv = CSV.read(file.path, headers: true)
    
    missing_headers = required_headers - csv.headers
    if missing_headers.any?
      raise "CSVのフォーマットが正しくありません。"
    end
    
    errors = []
    
    csv.each.with_index(2) do |row, line_number|
      begin
        product = find_or_initialize_by(product_code: row["商品コード"])
        product.assign_attributes(
          product_name: row["商品名"],
          case_quantity: row["入数"],
          standard_price_a: row["A単価"],
          standard_price_b: row["B単価"],
          standard_price_c: row["C単価"],
          notes: row["備考"]
        )
        product.save!
      rescue => e
        errors << "#{line_number}行目: #{e.message}"
      end
    end
    
    raise errors.join("\n") if errors.any?
  end
end
