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
  acts_as_taggable

  belongs_to :user
  belongs_to :category
  has_many :reviews,     dependent: :destroy
  has_many :favorites,   dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates  :title,        presence: true, ng_word: true, length: { in: 2..30 }
  validates  :content,      presence: true, ng_word: true, length: { maximum: 255 }
  validates  :category_id,  presence: true
  validates  :user_id,      presence: true
  paginates_per 8

  mount_uploader :image, ImagesUploader
  extend Enumerize
  enumerize :level, in: %i[easy normal hard], scope: true
  enumerize :volume, in: %i[few medium many], scope: true

  # 出力する属性、順番を定義
  def self.csv_attributes
    %w[ id
        title
        content
        category_id
        level volume
        created_at
        updated_at
        user_id]
  end

  # csvエクスポート
  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.find_each do |book|
        csv << csv_attributes.map { |attr| book.send(attr) }
      end
    end
  end

  # CSVインポート
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      book = Book.find_by(id: row['id']) || new
      book.attributes = row.to_hash.slice(*csv_attributes)
      book.save!
    end
  end

  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_notification_review!(current_user, review_id, visited_id)
    notification = current_user.active_notifications.new(
      book_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: 'review'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # 検索機能
  scope :search, lambda { |search_params|
    return if search_params.blank?

    title_like(search_params[:title])
      .category_id_is(search_params[:category_id])
      .level_is(search_params[:level])
      .volume_is(search_params[:volume])
  }
  scope :title_like, lambda { |title|
                       where('title LIKE ?', "%#{title}%") if title.present?
                     }
  scope :category_id_is, lambda { |category|
                           where(category_id: category) if category.present?
                         }
  scope :volume_is, ->(volume) { where(volume: volume) if volume.present? }
  scope :level_is, ->(level) { where(level: level) if level.present? }
end
