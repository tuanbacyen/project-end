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

  def can_show_list
    user_confirmed
    unless current_user.can_show_list?
      flash[:danger] = "Ban khong co quyen"
      redirect_to root_path
    end
  end

  def can_permission? user_request
    user_confirmed
    if current_user.get_role <= user_request.get_role && current_user.id != user_request.id
      flash[:danger] = "Ban khong co quyen"
    end
  end

  def convert_date date
    Date.strptime(date, t("date")).strftime("%Y/%m/%d") if date.present?
  rescue Exception
    date
  end

  def convert_date_to_local date
    date&.strftime(t("date")) if date
  end

  def convert_role role
    case role
      when "admin"
        return 3
      when "manage"
        return 2
      when "teacher"
        return 1
      else
        return 0
    end
  end
end
