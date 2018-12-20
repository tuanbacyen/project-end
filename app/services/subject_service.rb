class SubjectService
  def initialize params
    @params = params
  end

  def auto_create_subject
    list_subjects = @params[:check_subject]
    list_subjects.each do |subject|
      Subject.create! name: subject
    end
  end
end
