class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def user_not_authorized
    flash[:alert] = I18n.t('shared.not_authorized')
    redirect_to(request.referrer || root_path)
  end

end
