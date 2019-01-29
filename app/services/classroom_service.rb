class ClassroomService
  def initialize classroom
    @classroom = classroom
  end

  def create
    subject = SchoolSubject.where(school_id: @classroom.school.id, number: @classroom.number)
    subject.each do |s|
      ClassSubject.create(
        user_subject_id: s.subject.user_subjects.order("RAND()").first.id,
        classroom_id: @classroom.id
      )
    end
  end
end
