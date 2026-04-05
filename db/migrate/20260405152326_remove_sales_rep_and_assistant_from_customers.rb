class RemoveSalesRepAndAssistantFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_column :customers, :sales_rep_id, :integer
    remove_column :customers, :assistant_id, :integer
  end
end
