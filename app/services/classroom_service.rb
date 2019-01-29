class ClassroomService
  def initialize classroom
    @classroom = classroom
  end

  def create
    ssubject = SchoolSubject.where(school_id: @classroom.school.id, number: @classroom.number)
    ssubject.each do |ss|
      ClassSubject.create(
        user_subject_id: teacher(ss.subject, @classroom),
        classroom_id: @classroom.id
      )
    end
  end

  def teacher subject, classroom
    subject.is_activitie? ? classroom.teacher.get_activitie_subject.id : subject.user_subjects.order("RAND()").first.id
  end
end
