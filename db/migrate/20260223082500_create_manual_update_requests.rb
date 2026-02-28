class CreateManualUpdateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :manual_update_requests do |t|
      t.references :manual, null: false, foreign_key: true
      t.integer :requested_by_id
      t.integer :status
      t.text :request_note
      t.text :response_note

      t.timestamps
    end
  end
end
