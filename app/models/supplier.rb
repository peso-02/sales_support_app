class Supplier < ApplicationRecord
  has_many :supplier_contacts, dependent: :destroy
  
  # 支払条件を日本語で表示
  def payment_terms_display
    closing = closing_day == 99 ? "月末" : "#{closing_day}日"
    payment = payment_day == 99 ? "月末" : "#{payment_day}日"
    "#{closing}締め／#{payment_terms}ヶ月後の#{payment}払い"
  end

  def self.to_csv
    require 'csv'
    
    CSV.generate(headers: true) do |csv|
      csv << [
        "仕入先コード",
        "仕入先名",
        "締日",
        "支払サイト",
        "支払日",
        "ケース割れ発注可否",
        "ケース割れ送料",
        "備考"
      ]
      
      all.each do |supplier|
        csv << [
          supplier.supplier_code,
          supplier.supplier_name,
          supplier.closing_day,
          supplier.payment_terms,
          supplier.payment_day,
          supplier.case_break_order_allowed ? "可" : "否",
          supplier.case_break_order_fee,
          supplier.notes
        ]
      end
    end
  end
end