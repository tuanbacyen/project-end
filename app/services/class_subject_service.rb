class ClassSubjectService
  def initialize params
    @params = params
  end

  def create_cs
    classroom = Classroom.find_by(id: @params[:classroom_id].to_i)
    classroom.class_subjects.destroy_all if classroom
    list_subjects_ids = @params[:check_class_subject].map(&:to_i)
    list_subjects_ids.each do |subject_id|
      us = UserSubject.where(user_id: @params["teacher_#{subject_id}"], subject_id: subject_id).first
      ClassSubject.create!(classroom_id: @params[:classroom_id].to_i, user_subject_id: us.id) if us
    end
  end
end
