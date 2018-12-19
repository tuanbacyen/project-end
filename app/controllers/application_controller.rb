class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def user_confirmed
    return if current_user.nil?
    render "pages/need_confirmed" unless current_user.confirmed
  end

  def convert_date date
    Date.strptime(date, t("date")).strftime("%Y/%m/%d") if date.present?
  rescue OtherError
    date
  end

  def convert_date_to_local date
    date&.strftime(t("date")) if date
  end
end
