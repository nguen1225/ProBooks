# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  body       :text
#  rate       :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :integer
#  user_id    :integer
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#  index_reviews_on_user_id  (user_id)
#
class Review < ApplicationRecord
  validates :title,   presence: true, length: { maximum: 55 }, ng_word: true
  validates :body,    presence: true, length: { maximum: 255 }, ng_word: true
  validates :rate,    presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  belongs_to :user
  belongs_to :book
  has_many   :claps, dependent: :destroy
  has_many   :notifications, dependent: :destroy
  paginates_per 5

 #参考になった機能(判定)
  def already_clap_by?(user)
    claps.where(review_id: self.id).exists?
  end

  #通知作成メソッド
  def create_notification_clap!(current_user)
    #いいねの検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and review_id = ? and action = ?', current_user.id, user_id, id, 'clap'])
    #いいねされていない場合,通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'clap'
      )
      #通知を送ったユーザと送られたユーザーが一緒ならチェック
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
