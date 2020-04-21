class ClapsController < ApplicationController
  # after_action :level_up, only: [:create]

  def create
    @review = Review.find(params[:review_id])
    @book = Book.find(params[:book_id])
    @clap = current_user.claps.create(clap_params)
    @review.create_notification_clap!(current_user)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @book = Book.find(params[:book_id])
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

    totalExp = @user.experience_point
    totalExp += clap_count

    @user.experience_point = totalExp
    @user.update(experience_point: totalExp)

    level = LevelStandard.find_by(level: @user.level + 1)

    if level.threshould <= @user.experience_point
      @user.level = @user.level + 1
      @user.update(level: @user.level)
    end
  end
end
