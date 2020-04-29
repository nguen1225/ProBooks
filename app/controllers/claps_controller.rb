class ClapsController < ApplicationController
  include SetInstance
  before_action :set_book_id
  before_action :set_review
  after_action :level_up, only: [:create]

  def create
    @clap = current_user.claps.create(clap_params)
    @review.create_notification_clap!(current_user)
  end

  def destroy
    @clap = current_user.claps.find_by(clap_params)
    @clap.destroy
  end

  private

  def clap_params
    params.permit(:review_id)
  end

  def level_up
    @user = @review.user
    clap_count = 1

    total_exp = @user.experience_point
    total_exp += clap_count

    @user.experience_point = total_exp
    @user.update(experience_point: total_exp)

    level = LevelStandard.find_by(level: @user.level + 1)

    if level.threshould <= @user.experience_point
      @user.level = @user.level + 1
      @user.update(level: @user.level)
    end
  end
end
