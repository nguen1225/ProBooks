class CreateLevelStandards < ActiveRecord::Migration[5.2]
  def change
    create_table :level_standards do |t|
      t.integer :level
      t.integer :threshould

      t.timestamps
    end
  end
end
