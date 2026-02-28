class CreateManuals < ActiveRecord::Migration[7.1]
  def change
    create_table :manuals do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :title
      t.integer :file_status
      t.integer :approved_by_id
      t.datetime :approved_at

      t.timestamps
    end
  end
end
