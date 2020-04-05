require 'rails_helper'

RSpec.describe User, type: :model do
  it '全項目が正しく入力されていれば有効な状態' do
    user = User.new(
      name: 'テスト',
      email: 'test@example.com',
      introduction: 'テストです',
      admin: 1,
      status: 1,
      password: 'hogehoge',
      password_confirmation: 'hogehoge'
    )
    expect(user).to be_valid
  end

  it '名前な未入力であれば無効' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'メールアドレスが未入力であれば無効' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'パスワードが未入力であれば無効' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it '確認用パスワードが未入力であれば無効' do
    user = User.new(password_confirmation: nil)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end
end
