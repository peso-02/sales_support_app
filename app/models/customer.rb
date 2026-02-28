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

end
