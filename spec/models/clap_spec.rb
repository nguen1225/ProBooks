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
# require 'rails_helper'

# RSpec.describe Clap, type: :model do
#   before do
#     user = FactoryBot.create(:user)
#     category = FactoryBot.create(:category)
#     book = FactoryBot.create(:book, user_id: user.id, category_id: category.id)
#     @review = FactoryBot.create(:review, user_id: user.id, book_id: book.id)
#   end

#   it '同じレビューに拍手するユーザの重複があると無効' do
#     clap_user = FactoryBot.create(:user)
#     first_clap = Clap.create(
#       review_id: @review.id,
#       user_id: clap_user
#     )
#     second_clap = Clap.build(
#       review_id: @review.id,
#       user_id: clap_user
#     )
#     second_clap.valid?
#     expect(second_clap.errors[:clap]).to include('すでに存在しています')
#   end
# end
