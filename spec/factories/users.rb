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
FactoryBot.define do
  factory :user do
    name { 'テスト' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    status { 'engineer' }
    introduction { 'テストユーザーの自己紹介' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    sequence(:uid) { |n| "#{n}12345" }
    provider { 'github' }
  end
end
