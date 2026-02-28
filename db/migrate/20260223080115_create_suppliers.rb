class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :supplier_code
      t.string :supplier_name
      t.integer :closing_day
      t.integer :payment_terms
      t.boolean :case_break_order_allowed
      t.integer :case_break_order_fee
      t.text :notes

      t.timestamps
    end
  end
end
