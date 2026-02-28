class ManualUpdateRequest < ApplicationRecord
  belongs_to :manual
  belongs_to :requested_by, class_name: 'User'
  
  enum status: { pending: 0, approved: 1, rejected: 2 }
end
