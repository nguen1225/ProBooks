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
class Book < ApplicationRecord
  include Hashid::Rails
  acts_as_taggable

  belongs_to :user
  belongs_to :category
  has_many :reviews,     dependent: :destroy
  has_many :favorites,   dependent: :destroy

  validates  :title,        presence: true, ng_word: true
  validates  :content,      presence: true, ng_word: true
  validates  :category_id,  presence: true
  validates  :user_id,      presence: true

  mount_uploader :image, ImagesUploader

  extend Enumerize
  enumerize :level, in: %i[easy normal hard]
  enumerize :volume, in: %i[few medium many]

  #お気にり機能(判定)
  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #検索機能
  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .category_id_is(search_params[:category_id])
      .level_is(search_params[:level])
      .volume_is(search_params[:volume])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :category_id_is, -> (category) {where(category_id: category) if category.present? }
  scope :level_is, -> (level) { where(level: level) if level.present? }
  scope :volume_is, -> (volume) { where(volume: volume) if volume.present? }
end
