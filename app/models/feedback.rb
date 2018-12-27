class Feedback < ApplicationRecord
  validates :content, presence: true
  
  scope :load_all_feedbacks?, ->{order(status: :asc, created_at: :desc).select :id, :from_id, :content, :status, :created_at}
  scope :feedback_need_do?, ->{where status: false}

  def user_send
    User.find_by id: from_id
  end
end
