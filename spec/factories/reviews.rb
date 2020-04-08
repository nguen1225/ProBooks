# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  rate       :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#  index_reviews_on_user_id  (user_id)
#
FactoryBot.define do
  factory :review do
    title { 'MyString' }
    body { 'MyText' }
    rate { 1.5 }
    user_id { nil }
    book_id { nil }
  end
end
