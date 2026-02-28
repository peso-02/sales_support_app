class Manual < ApplicationRecord
  belongs_to :customer
  belongs_to :approved_by, class_name: 'User', optional: true
  has_many :manual_update_requests, dependent: :destroy
  
  # ファイルは Active Storage で後から追加
  
  enum file_status: { draft: 0, pending: 1, approved: 2, rejected: 3 }
end
