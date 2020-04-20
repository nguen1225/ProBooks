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
# require 'rails_helper'

# RSpec.describe Notification, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
