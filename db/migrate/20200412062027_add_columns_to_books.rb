class AddColumnsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :level, :string
    add_column :books, :volume, :string
  end
end
