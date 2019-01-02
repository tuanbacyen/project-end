module SchoolUserHelper
  def school_users user
    School.where.not(id: (user.school_users.pluck :school_id)).pluck(:name, :id)
  end
end
