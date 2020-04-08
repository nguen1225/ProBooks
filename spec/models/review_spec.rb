# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  rate       :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#  index_reviews_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book, user: @user)
  end

  context '有効なレビュー' do
    it '全項目が正しく入力されている' do
      review = Review.new(
        title: 'テスト',
        body: 'プロトタイプ',
        rate: 1.5,
        user_id: @user.id,
        book_id: @book.id
      )
      expect(review).to be_valid
    end

    it 'タイトルの文字数が54文字' do
      review = Review.new(title: 'a' * 55,
                          body: 'コンテンツ',
                          rate: 1,
                          user_id: @user.id,
                          book_id: @book.id)
      expect(review).to be_valid
    end

    it '内容の文字数が254文字' do
      review = Review.new(title: 'タイトル',
                          body: 'a' * 255,
                          rate: 1,
                          user_id: @user.id,
                          book_id: @book.id)
      expect(review).to be_valid
    end
  end

  context '無効なレビュー' do
    it 'タイトルが入力されていない' do
      review = Review.new(title: nil)
      review.valid?
      expect(review.errors[:title]).to include("can't be blank")
    end

    it 'Bodyが入力されていない' do
      review = Review.new(body: nil)
      review.valid?
      expect(review.errors[:body]).to include("can't be blank")
    end

    it 'rateが入力されていない' do
      review = Review.new(rate: nil)
      review.valid?
      expect(review.errors[:rate]).to include("can't be blank")
    end

    it 'user_idが入力されていない' do
      review = Review.new(user_id: nil)
      review.valid?
      expect(review.errors[:user_id]).to include("can't be blank")
    end

    it 'book_idが入力されていない' do
      review = Review.new(book_id: nil)
      review.valid?
      expect(review.errors[:book_id]).to include("can't be blank")
    end

    it 'タイトルが55文字以上' do
      review = Review.new(title: 'a' * 56)
      review.valid?
      expect(review.errors[:title]).to include('is too long (maximum is 55 characters)')
    end

    it '内容が255文字以上' do
      review = Review.new(body: 'a' * 256)
      review.valid?
      expect(review.errors[:body]).to include('is too long (maximum is 255 characters)')
    end
  end
end
