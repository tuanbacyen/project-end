class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def user_confirmed
    return if current_user.nil?
    render "pages/need_confirmed" unless current_user.confirmed
  end
end
