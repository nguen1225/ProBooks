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
class Book < ApplicationRecord
  acts_as_taggable

  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates  :title,     presence: true, ng_word: true
  validates  :content,   presence: true, ng_word: true
  validates  :category,  presence: true
  validates  :user_id,   presence: true

  mount_uploader :image, ImagesUploader

  extend Enumerize
  enumerize :category, in: %i[html javascript ruby php css]
  enumerize :level, in: %i[easy normal hard]
  enumerize :volume, in: %i[few medium many]

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .category_is(search_params[:category])
      .level_is(search_params[:level])
      .volume_is(search_params[:volume])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :category_is, -> (category) {where(category: category) if category.present? }
  scope :level_is, -> (level) { where(level: level) if level.present? }
  scope :volume_is, -> (volume) { where(volume: volume) if volume.present? }
end
