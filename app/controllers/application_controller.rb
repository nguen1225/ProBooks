class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_path(resource)
    elsif resource.is_a?(Admin)
      admins_root_path
    end
  end

  def after_sign_up_path(resource)
    user_path(resource)
  end

  # 管理者権限
  def admin_user
    redirect_to root_path, notice: '権限がありません' unless current_user.admin == true
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name
                                                         email
                                                         password
                                                         password_confirmation])
  end
end
