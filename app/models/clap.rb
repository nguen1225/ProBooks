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
#  index_claps_on_review_id              (review_id)
#  index_claps_on_user_id                (user_id)
#  index_claps_on_user_id_and_review_id  (user_id,review_id) UNIQUE
#
class Clap < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates_uniqueness_of :review_id, scope: :user_id
end
