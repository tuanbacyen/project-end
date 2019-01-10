module ClassroomsHelper
  def list_teacher_in_school teacher_id
    list_user = if teacher_id
                  User.where(id: teacher_id).pluck(:name, :birth, :id)
                else
                  User.load_user_of_school(current_user).load_teacher.user_has_classroom(Semester.first.id).pluck :name, :birth, :id
                end
    list = []
    list_user.map{|u| list << ["#{u[0]} - #{u[1].day}/#{u[1].month}/#{u[1].year}", u[2]]}
    list
  end

  def list_semester
    list_semesters = Semester.select :period, :start_date, :end_date, :id
    list = []
    list_semesters.map{|s| list << [name_semester(s), s.id]}
    list
  end

  def name_semester semester
    "#{key_to_text_semester semester.period} (#{convert_date_to_local semester.start_date} - #{convert_date_to_local semester.end_date})"
  end

  def convert_date_to_local date
    date&.strftime(t("date")) if date
  end
end
