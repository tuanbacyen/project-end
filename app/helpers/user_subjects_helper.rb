module UserSubjectsHelper
  def list_subject teacher_list_subject
    teacher_has = teacher_list_subject.user_subjects.pluck :subject_id
    list = []
    Subject.load_all_subjects?.map{|s| list << [s.id, s.name] unless teacher_has.include?(s.id)}
    list
  end
end
