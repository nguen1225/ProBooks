# == Schema Information
#
# Table name: level_standards
#
#  id         :integer          not null, primary key
#  level      :integer
#  threshould :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :level_standard do
    level { 2 }
    threshould { 3 }
  end
end
