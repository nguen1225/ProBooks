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
FactoryBot.define do
  factory :contact do
    name { 'メールユーザ' }
    email { 'hogehoge@email.com.com' }
    body { 'メール届いていますか？' }
  end
end
