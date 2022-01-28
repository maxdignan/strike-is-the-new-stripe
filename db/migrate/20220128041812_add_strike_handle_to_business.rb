class AddStrikeHandleToBusiness < ActiveRecord::Migration[6.0]
  def change
    add_column :businesses, :strike_user_handle, :string, null: false, default: ""
  end
end
