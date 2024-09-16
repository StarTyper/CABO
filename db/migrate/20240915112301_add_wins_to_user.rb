class AddWinsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wins, :integer, default: 0
  end
end
