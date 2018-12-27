module FeedbacksHelper
  def status_feedback_label feedback
    case feedback
    when true
      "<span class='label bg-blue'>Dã giải quyết</span>".html_safe
    else
      "<span class='label bg-red'>ĐM User chửi m kìa</span>".html_safe
    end
  end
end
