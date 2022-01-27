class AddSecrets < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :secret, :string, null: false
    add_column :customers, :secret, :string, null: false
  end
end
