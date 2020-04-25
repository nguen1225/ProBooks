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
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]
  # include Hashid::Rails
  acts_as_paranoid
  extend Enumerize
  enumerize :status, in: %i[engineer begineer]
  mount_uploader :image, ImagesUploader
  validates :email,                 presence: true
  validates :name,                  presence: true, ng_word: true, length: { minimum: 2 }
  validates :introduction,                          ng_word: true, length: { maximum: 255 }

  has_many  :books,     dependent: :destroy
  has_many  :reviews,   dependent: :destroy
  has_many  :claps,     dependent: :destroy
  has_many  :favorites, dependent: :destroy
  has_many  :active_notifications, class_name: 'Notification',
                                   foreign_key: 'visitor_id', dependent: :destroy
  has_many  :passive_notifications, class_name: 'Notification',
                                    foreign_key: 'visited_id', dependent: :destroy
  paginates_per 15

  def self.csv_attributes
    %w[id name email status created_at updated_at deleted_at uid provider]
  end

  # csvエクスポート
  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.find_each do |user|
        csv << csv_attributes.map { |attr| user.send(attr) }
      end
    end
  end


  # GitHub認証メソッド
  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, _signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    user ||= User.new(provider: auth.provider,
                      uid: auth.uid,
                      name: auth.info.name,
                      email: auth.info.email(auth),
                      password: Devise.friendly_token[0, 20])
    user.save(validate: false)
    user
  end

  # def self.dummy_email(auth)
  #   "#{auth.uid}-#{auth.provider}@example.com"
  # end

  scope :search, lambda { |search_params|
    return if search_params.blank?

    name_like(search_params[:name])
      .status_is(search_params[:status])
      .created_at_from(search_params[:created_at_from])
      .created_at_to(search_params[:created_at_to])
  }
  scope :name_like, lambda { |name|
                      where('name LIKE ?', "%#{name}%") if name.present?
                    }
  scope :status_is, ->(status) { where(status: status) if status.present? }
  scope :created_at_from, lambda { |from|
                            where('? <= created_at', from) if from.present?
                          }
  scope :created_at_to, ->(to) { where('created_at <= ?', to) if to.present? }

  #ユーザー情報更新
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
