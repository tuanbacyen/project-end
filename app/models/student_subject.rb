class StudentSubject < ApplicationRecord
  has_many :points, dependent: :destroy

  belongs_to :class_subject
  belongs_to :student_classroom

  def name_subject
    class_subject.teacher.subject.name
  end

  def name_teacher
    class_subject.teacher.teacher.name
  end

  def update_average
    score = score_average(points)
    update average: score, classification: score_to_classification(score)
  end

  private
  def score_average points
    mouth = points.load_point_mouth.pluck(:point)
    fifteen = points.load_point_fifteen.pluck(:point)
    sixty = points.load_point_sixty.pluck(:point)
    finish = points.load_point_finish.pluck(:point)
    mouth = mouth.size.zero? ? 0 : (mouth.reduce(0){|a, e| a + e}.to_f / mouth.size)
    fifteen = fifteen.size.zero? ? 0 : (fifteen.reduce(0){|a, e| a + e}.to_f / fifteen.size)
    sixty = sixty.size.zero? ? 0 : (sixty.reduce(0){|a, e| a + e}.to_f / sixty.size)
    finish = finish.size.zero? ? 0 : (finish.reduce(0){|a, e| a + e}.to_f / finish.size)
    (((mouth + fifteen) + sixty * 2 + finish * 3).to_f / 7).round(2)
  end

  def score_to_classification score
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
