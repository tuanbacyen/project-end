module StudentsHelper
  def list_parent_in_school
    list_user = User.load_user_of_school(current_user).load_parent.pluck :name, :phone, :identity_card, :birth, :id
    list = []
    list_user.map{|u| list << ["#{u[0]} - #{u[1]}- #{u[2]} - #{u[3].day}/#{u[3].month}/#{u[3].year}", u[4]]}
    list
  end

  def studying_label studying
    case studying
    when true
      "<span class='label bg-green'>Studying</span>".html_safe
    when false
      "<span class='label bg-red'>Not Studying</span>".html_safe
    end
  end
end
