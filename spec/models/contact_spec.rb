# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Contact, type: :model do
  it '入力項目を全てを入力していれば有効' do
    contact = Contact.new(
      name: "user",
      email: "user@email.com",
      body: "お問い合わせ内容の確認",
    )
    expect(contact).to be_valid
  end

  it '名前が入力されていなければ無効' do
    contact = Contact.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  it 'メールアドレスが入力されていなければ無効' do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end

  it '内容が入力されていなければ無効' do
    contact = Contact.new(body: nil)
    contact.valid?
    expect(contact.errors[:body]).to include('を入力してください')
  end
end
