module StudentSubjectsHelper
  def average_of_student_in_class student_classroom
    return "chưa có điểm" unless student_classroom.student_subjects.present?
    student_classroom.student_subjects.average(:average).to_f.round(2)
  end

  def score_to_text student_classroom
    score = average_of_student_in_class student_classroom
    return score if score.is_a? String
    case score
    when 0..3.5
      "Đúp"
    when 3.5..5
      "Yếu"
    when 5..6.5
      "Trung bình"
    when 6.5..8
      "Khá"
    else
      "Giỏi"
    end
  end
end
