class CreateClaps < ActiveRecord::Migration[5.2]
  def change
    create_table :claps do |t|
      t.references  :user,  index: true, foreign_key: true
      t.references  :review, index: true, foreign_key: true

      t.timestamps
    end
  end
end
