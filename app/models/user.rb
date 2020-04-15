# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  introduction           :text
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
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider_and_uid      (provider,uid) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]
  include Hashid::Rails
  extend Enumerize
  enumerize :status, in: %i[engineer begineer]
  mount_uploader :image, ImagesUploader
  validates :name, ng_word: true
  validates :introduction, ng_word:  true
  # validates :email, presence: true
  # validates :password, presence: true
  # validates :password_confirmation, presence: true
  has_many  :books,   dependent: :destroy
  has_many  :reviews, dependent: :destroy
  has_many  :claps,   dependent: :destroy
  has_many  :favorites, dependent: :destroy

  # GitHub認証メソッド
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, _signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    user ||= User.new(provider: auth.provider,
                      uid: auth.uid,
                      name: auth.info.name,
                      email: User.dummy_email(auth),
                      password: Devise.friendly_token[0, 20])
    user.save
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
