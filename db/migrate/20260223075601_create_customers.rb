class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :customer_code
      t.string :customer_name
      t.integer :closing_day
      t.integer :payment_terms
      t.string :business_type
      t.boolean :case_break_shipping_allowed
      t.integer :case_break_shipping_fee
      t.integer :delivery_note_type
      t.integer :order_method
      t.integer :sales_rep_id
      t.integer :assistant_id
      t.text :notes

      t.timestamps
    end
  end
end
