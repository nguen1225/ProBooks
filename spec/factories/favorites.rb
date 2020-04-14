# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  user_id    :integer
#
FactoryBot.define do
  factory :favorite do
    user_id { 1 }
    book_id { 1 }
  end
end
