module SchoolSubjectsHelper
  def list_number_select list_number, action
    number = Settings.list_class_num.to_h
    if action == "edit"
      number = [[list_number, number[list_number]]]
    else
      list_number.map{|num| number.delete(num)}
    end
    number
  end

  def value_check_subject action, subject_id, list_subject
    return true if action == "new"
    list_subject.include? subject_id
  end
end
