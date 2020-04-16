# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  action     :string           default(""), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  review_id  :integer
#  visited_id :integer          not null
#  visitor_id :integer          not null
#
# Indexes
#
#  index_notifications_on_book_id     (book_id)
#  index_notifications_on_review_id   (review_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
class Notification < ApplicationRecord
	default_scope -> { order(created_at: :desc) }
	belongs_to :book,   optional: true
	belongs_to :review, optional: true
	belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
	belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
