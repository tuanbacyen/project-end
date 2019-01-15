module StudentSubjectsHelper
  def average_of_student_in_class student_classroom
    return "chưa có điểm" unless student_classroom.student_subjects.present?
    student_classroom.student_subjects.average(:average).to_f.round(2)
  end

  def score_to_text student_classroom
    return "chưa có điểm" unless student_classroom.student_subjects.present?
    score = student_classroom.student_subjects.average(:average).to_f.round(2)
    if score < 3.5
      "Đúp"
    elsif score >= 3.5 && score < 5
      "Yếu"
    elsif score >= 5 && score < 6.5
      "Trung bình"
    elsif score >= 6.5 && score < 8
      "Khá"
    elsif score >= 8
      "Giỏi"
    end
  end
end
