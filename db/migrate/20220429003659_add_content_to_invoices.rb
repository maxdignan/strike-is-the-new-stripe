class AddContentToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :amount, :float, null: false, default: 0.00
    add_column :invoices, :paid, :boolean, null: false, default: false
  end
end
