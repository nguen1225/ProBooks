class CreateClaps < ActiveRecord::Migration[5.2]
  def change
    create_table :claps do |t|
      t.references :user, foreign_key: true, index: true
      t.references :review, foreign_key: true, index: true

      t.timestamps
    end
  end
end
