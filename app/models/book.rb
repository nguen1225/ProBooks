# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  category   :string           not null
#  content    :text
#  image      :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
class Book < ApplicationRecord
  extend Enumerize
  acts_as_taggable

  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates  :title,     presence: true, ng_word: true
  validates  :content,   presence: true, ng_word: true
  validates  :category,  presence: true
  validates  :user_id,   presence: true

  mount_uploader :image, ImagesUploader
  enumerize :category, in: %i[html javascript ruby php css]

  scope :search, -> (search_params) do
    return if search_params.blank?

    title_like(search_params[:title])
      .category_is(search_params[:category])
      .user_id_is(search_params[:user_id])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :category_is, -> (category) {where(category: category) if category.present? }
  scope :user_id_is, -> (user_id) {where(user_id: user_id) if user_id.present? }
end
