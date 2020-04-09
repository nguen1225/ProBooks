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
require 'rails_helper'

RSpec.describe Clap, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
