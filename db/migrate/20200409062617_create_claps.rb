class CreateClaps < ActiveRecord::Migration[5.2]
  def change
    create_table :claps do |t|
      t.references  :user, index: { name: 'user_id_claps' }, foreign_key: true
      t.references  :review, index: { name: 'review_id_claps' }, foreign_key: true

      t.timestamps
    end
  end
end
