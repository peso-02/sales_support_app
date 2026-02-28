class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :product_name
      t.integer :case_quantity
      t.decimal :standard_price_a
      t.decimal :standard_price_b
      t.decimal :standard_price_c
      t.text :notes

      t.timestamps
    end
  end
end
