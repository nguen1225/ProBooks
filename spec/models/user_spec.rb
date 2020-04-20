# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  experience_point       :integer          default(0)
#  image                  :string
#  introduction           :text
#  level                  :integer          default(1)
#  name                   :string           not null
#  provider               :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  status                 :string
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider_and_uid      (provider,uid) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  it '全項目が正しく入力されていれば有効な状態' do
    user = User.new(
      name: 'テスト',
      email: 'test@example.com',
      introduction: 'テストです',
      status: 'engineer',
      password: 'hogehoge',
      password_confirmation: 'hogehoge'
    )
    expect(user).to be_valid
  end

  it '名前な未入力であれば無効' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end


  it '名前の文字数が1文字以下であれば無効' do
    user = User.new(name: "a")
    user.valid?
    expect(user.errors[:name]).to include("は2文字以上で入力してください")
  end

  it '重複したメールアドレスであれば無効' do
    User.create!(
      name: 'テスト',
      email: 'test@example.com',
      introduction: 'テストです',
      status: 'engineer',
      password: 'hogehoge',
      password_confirmation: 'hogehoge'
    )
    user = User.new(
      name: 'テスター',
      email: 'test@example.com',
      introduction: 'テストです',
      status: 'engineer',
      password: 'hogehoge',
      password_confirmation: 'hogehoge'
    )
    user.valid?
    expect(user.errors[:email]).to include("すでに使用されています")
  end


  it 'メールアドレスが未入力であれば無効' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it 'パスワードが未入力であれば無効' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it '確認用パスワードが未入力であれば無効' do
    user = User.new(password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("を入力してください")
  end

  it '名前にNGワードが含まれていれば無効' do
    user = User.new(name: 'うんこ')
    user.valid?
    expect(user.errors[:name]).to include('のうんこはNGワードです')
  end

  it '自己紹介文にNGワードが含まれている' do
    user = User.new(introduction: 'うんこ')
    user.valid?
    expect(user.errors[:introduction]).to include('のうんこはNGワードです')
  end
end
