class AddDescriptionToInvoice < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :description, :string, null: false, default: ""
  end
end
