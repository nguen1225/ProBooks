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
	validates :email, presence: true
	validates :body,  presence: true
end
