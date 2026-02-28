class AddPaymentDayToSuppliers < ActiveRecord::Migration[7.1]
  def change
    add_column :suppliers, :payment_day, :integer
  end
end
