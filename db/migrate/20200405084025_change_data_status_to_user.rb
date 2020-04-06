class ChangeDataStatusToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :status, :string
  end
end
