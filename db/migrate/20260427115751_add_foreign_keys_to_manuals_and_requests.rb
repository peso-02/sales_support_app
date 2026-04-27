class AddForeignKeysToManualsAndRequests < ActiveRecord::Migration[7.1]
  def change
    change_column :manuals, :approved_by_id, :bigint
    change_column :manual_update_requests, :requested_by_id, :bigint

    add_foreign_key :manuals, :users, column: :approved_by_id
    add_foreign_key :manual_update_requests, :users, column: :requested_by_id
  end
end