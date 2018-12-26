module ManagerUsersHelper
  def user_roles
    User.roles.map{|p| p[0] = key_to_text_user(p[0]), p[1] = p[0]}[0..-2]
  end

  def key_to_text_user key
    return "parent" if key == "student_parent"
    return "teacher" if key == "teacher"
    "manage"
  end

  def gender_user gender
    return "<i class='fa fa-male'> Nam</i>".html_safe if gender
    return "<i class='fa fa-female'> Nu</i>".html_safe if gender == false
    return "<i class='fa fa-adjust'> Khac</i>".html_safe
  end

  def working_label working
    status = "success"
    text = "Working"
    unless working
      status = "danger"
      text = "Inactivity"      
    end
    "<span class='label label-#{status}'>#{text}</span>".html_safe
  end

  def role_label role
    case role
      when "admin"
        "<span class='label bg-red'>Admin</span>".html_safe
      when "manage"
        "<span class='label bg-orange'>Mange</span>".html_safe
      when "teacher"
        "<span class='label bg-blue'>Teacher</span>".html_safe
      when "student_parent"
        "<span class='label bg-yellow'>Parent</span>".html_safe
    end
  end
end
