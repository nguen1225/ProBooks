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
    sequence(:title) { |n| "テスト駆動開発#{n}" }
    sequence(:content) { |n| "テストは最初に書こう#{n}" }
    user
    category
  end

  factory :book_c, class: Book do
    title { 'EverydayRails' }
    content { 'write some test code!!' }
    user_id { 1 }
    category_id { 1 }

    trait :invalid do
      title { nil }
    end
  end
end
