module NotificationsHelper
  # 通知確認のチェックヘルパー
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
