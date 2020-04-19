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
require 'rails_helper'

RSpec.describe LevelStandard, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
