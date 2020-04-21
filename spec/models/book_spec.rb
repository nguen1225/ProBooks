# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  content     :text
#  image       :string
#  level       :string
#  title       :string           not null
#  volume      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer          not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:image_path) { File.join(Rails.root, 'app/assets/images/default.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
  end

  describe 'バリデーション' do
    it '全項目が正しく入力されていれば有効な状態' do
      book = Book.new(
        title: 'テストを学ぼう',
        content: 'ホゲホゲホゲホゲホゲ',
        category_id: @category.id,
        image: image,
        user_id: @user.id
      )
      expect(book).to be_valid
    end

    it 'タイトルが未入力であれば無効' do
      book = Book.new(title: nil)
      book.valid?
      expect(book.errors[:title]).to include('を入力してください')
    end

    it 'タイトルの文字数2文字以下であれば無効' do
      book = Book.new(title: 'a')
      book.valid?
      expect(book.errors[:title]).to include('は2文字以上で入力してください')
    end

    it 'タイトルの文字数51文字以上であれば無効' do
      book = Book.new(title: 'a' * 51)
      book.valid?
      expect(book.errors[:title]).to include('は30文字以内で入力してください')
    end

    it 'カテゴリーが未入力であれば無効' do
      book = Book.new(category_id: nil)
      book.valid?
      expect(book.errors[:category_id]).to include('を入力してください')
    end

    it 'ユーザーIDが未入力であれば無効' do
      book = Book.new(user_id: nil)
      book.valid?
      expect(book.errors[:user_id]).to include('を入力してください')
    end

    it 'タイトルにNGワードが含まれている' do
      book = Book.new(title: 'うんこ')
      book.valid?
      expect(book.errors[:title]).to include('のうんこはNGワードです')
    end

    it '内容にNGワードが含まれている' do
      book = Book.new(content: 'うんこ')
      book.valid?
      expect(book.errors[:content]).to include('のうんこはNGワードです')
    end
  end
end
