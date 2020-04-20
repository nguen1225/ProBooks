# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  content     :text
#  image       :string
#  level       :string
#  title       :string           not null
#  volume      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer          not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
FactoryBot.define do
  factory :book do
    title { 'テスト' }
    content { 'テストコンテント' }
  end
end
