class Customer < ApplicationRecord
  enum delivery_note_type: { separate_later: 1, with_product: 2, not_required: 3 }
  enum order_method: { web_edi: 0, email: 1, fax: 2 }
  
  has_many :product_prices, dependent: :destroy
  has_many :products, through: :product_prices
  has_many :manuals, dependent: :destroy
  
  belongs_to :sales_rep, class_name: 'User', optional: true
  belongs_to :assistant, class_name: 'User', optional: true

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
        "得意先コード",
        "得意先名",
        "締日",
        "支払サイト",
        "支払日",
        "業態",
        "ケース割れ出荷可否",
        "ケース割れ送料",
        "納品書タイプ",
        "発注方法",
        "備考"
      ]
      
      all.each do |customer|
        csv << [
          customer.customer_code,
          customer.customer_name,
          customer.closing_day,
          customer.payment_terms,
          customer.payment_day,
          customer.business_type,
          customer.case_break_shipping_allowed ? "可" : "否",
          customer.case_break_shipping_fee,
          customer.delivery_note_type,
          customer.order_method,
          customer.notes
        ]
      end
    end
  end
end
