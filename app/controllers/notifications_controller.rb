class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = current_user.passive_notifications
                                 .preload(:visitor, :visited, :book)
                                 .page(params[:page])
                                 .per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
