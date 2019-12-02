class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_approved

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :avatar, :header, :password, :current_password, :bio, :user)}
    end

  private
  def user_not_authorized
    flash[:alert] = I18n.t('shared.not_authorized')
    redirect_to(request.referrer || root_path)
  end

  def check_approved
    if current_user && !current_user.approved
      flash[:alert] = I18n.t('shared.not_approved')
    end
  end

end
