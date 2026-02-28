class AddPaymentDayToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :payment_day, :integer
  end
end
