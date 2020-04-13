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
require 'rails_helper'

RSpec.describe Clap, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
