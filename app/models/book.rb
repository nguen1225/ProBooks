# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  category   :string           not null
#  content    :text
#  image      :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
class Book < ApplicationRecord
	extend Enumerize
	belongs_to :user

	validates :title, presence: true
	validates :category, presence: true
	validates :user_id,  presence: true

	enumerize :category, in: %i(html javascript ruby php)
end
