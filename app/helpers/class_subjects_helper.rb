module ClassSubjectsHelper
  def list_teacher_subject subject
    list_user = User.load_teacher_of_school(current_user.first_school.id, subject.list_teacher).uniq.pluck :name, :birth, :id
    user_collection_select list_user
  end
end
