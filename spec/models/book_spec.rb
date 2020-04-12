# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  category   :string           not null
#  content    :text
#  image      :string
#  level      :string
#  title      :string           not null
#  volume     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:image_path) { File.join(Rails.root, 'app/assets/images/rails.png') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  it '全項目が正しく入力されていれば有効な状態' do
    user = FactoryBot.create(:user)
    book = Book.new(
      title: 'テストを学ぼう',
      content: 'ホゲホゲホゲホゲホゲ',
      category: 'html',
      image: image,
      user_id: user.id
    )
    expect(book).to be_valid
  end

  it 'タイトルが未入力であれば無効' do
    book = Book.new(title: nil)
    book.valid?
    expect(book.errors[:title]).to include("can't be blank")
  end

  it 'カテゴリーが未入力であれば無効' do
    book = Book.new(category: nil)
    book.valid?
    expect(book.errors[:category]).to include("can't be blank")
  end

  it 'ユーザーIDが未入力であれば無効' do
    book = Book.new(user_id: nil)
    book.valid?
    expect(book.errors[:user_id]).to include("can't be blank")
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
