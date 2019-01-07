module StudentClassroomsHelper
  def list_class_can_join student
    list = []
    current_user.manage_get_classroom
      .map{|c| list << [c.show_classroom, c.id] unless student.student_classrooms.pluck(:classroom_id).include? c.id}
    list
  end
end
