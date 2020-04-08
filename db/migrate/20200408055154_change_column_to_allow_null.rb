class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :status, :string, null: true
  end

  def down
    change_column :users, :status, :string, null: false
  end
end
