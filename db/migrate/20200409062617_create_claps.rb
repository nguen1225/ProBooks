class CreateClaps < ActiveRecord::Migration[5.2]
  def change
    create_table :claps do |t|
      t.references :user
      t.references :review

      t.timestamps
    end
    add_index :claps, [:user_id, :review_id], unique: true
    add_foreign_key :user, :review
  end
end
