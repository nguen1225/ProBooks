# == Schema Information
#
# Table name: claps
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  review_id  :integer
#  user_id    :integer
#
# Indexes
#
#  review_id_claps  (review_id)
#  user_id_claps    (user_id)
#
class Clap < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :review_id, uniqueness: { scope: :user_id }
end
