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
class Review < ApplicationRecord
  validates :title,   presence: true, length: { maximum: 55 }
  validates :body,    presence: true, length: { maximum: 255 }
  validates :rate,    presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book
  has_many   :claps, dependent: :destroy
end
