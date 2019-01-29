class SubjectService
  def initialize params
    @params = params
  end

  def auto_create_subject
    list_subjects = @params[:check_subject]
    list_subjects.each do |subject|
      sb_code = Settings.list_code_subject[Settings.list_default_subject.find_index(subject)]
      Subject.create! name: subject, subject_code: sb_code
    end
  end
end
