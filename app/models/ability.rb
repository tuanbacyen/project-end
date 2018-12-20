class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, [School, Semester, Unit, Subject, NotifyType]
    elsif user.manage?
    elsif user.teacher?
    elsif user.student_parent?
    end
  end
end
