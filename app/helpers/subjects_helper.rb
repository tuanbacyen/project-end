module SubjectsHelper
  def list_subject_default
    Settings.list_default_subject - Subject.list_subject_exists?
  end
end
