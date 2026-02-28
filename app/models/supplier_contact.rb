class Supplier < ApplicationRecord
  has_many :supplier_contacts, dependent: :destroy
  
  # ケース割れ発注可否のenum
  # case_break_order_allowed が boolean なので enum は不要
end
