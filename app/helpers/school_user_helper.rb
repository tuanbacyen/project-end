module SchoolUserHelper
  def school_users user
    School.where.not(id: (user.school_users.pluck :school_id)).pluck(:name, :id)
  end

  def load_school_collection
    if current_user.admin?
      School.pluck :name, :id
    else
      [[current_user.first_school.name, current_user.first_school.id]]
    end
  end

  def load_student_collection school_id
    list_students = Student.where(school_id: school_id).student_no_parent.pluck :name, :id, :student_code, :birth
    list = []
    list_students.map{|s| list << ["#{s[2]} - #{s[0]} - #{s[3].day}/#{s[3].month}/#{s[3].year}", s[1]]}
    list
  end
end
