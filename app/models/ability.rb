class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can [:create, :new], Feedback
    if user.admin?
      can :manage, [School, Semester, Unit, Subject, NotifyType, User, Feedback, SchoolUser]
      cannot [:edit, :update, :destroy], User do |user|
        user.admin?
      end
      cannot :destroy, User, id: user.id
      can [:edit, :update], User, id: user.id
    elsif user.manage?
    elsif user.teacher?
    elsif user.student_parent?
      can [:show, :edit, :update], User, id: user.id
    end
  end
end
