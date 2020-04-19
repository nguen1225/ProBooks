# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
	validates :name,  presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,
				format: { with: VALID_EMAIL_REGEX }
	validates :body,  presence: true
end
