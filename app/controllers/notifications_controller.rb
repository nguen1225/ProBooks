class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :visited, :book).page(params[:page]).per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end