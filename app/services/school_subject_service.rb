class SchoolSubjectService
  def initialize params, manage
    @params = params
    @manage = manage
  end

  def create_school_subject
    number = @params[:number]
    school_id = @manage.first_school.id
    list_subject = @params[:check_number].map(&:to_i)
    list_subject.each do |sub_id|
      SchoolSubject.create number: number, school_id: school_id, subject_id: sub_id
    end
  end

  def update_school_subject
    number = @params[:number]
    school_id = @manage.first_school.id
    list_subject = @params[:check_number].map(&:to_i)
    list_subject_old = SchoolSubject.where(school_id: 2, number:11).pluck :subject_id

    list_create = list_subject - list_subject_old
    list_destroy = list_subject_old - list_subject

    list_create.each do |sub_id|
      SchoolSubject.create number: number, school_id: school_id, subject_id: sub_id
    end

    list_destroy.each do |sub_id|
      ss = SchoolSubject.where number: number, school_id: school_id, subject_id: sub_id
      ss.first.destroy
    end
  end
end
