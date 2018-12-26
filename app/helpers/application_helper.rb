module ApplicationHelper
  def convert_date date
    date&.strftime(t("date")) if date
  end
end
