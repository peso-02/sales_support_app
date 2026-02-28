class CreateSupplierContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :supplier_contacts do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :contact_name
      t.string :email
      t.string :phone
      t.string :fax
      t.text :notes

      t.timestamps
    end
  end
end
