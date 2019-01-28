class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    can [:create, :new], Feedback
    can [:show, :edit, :update], User, id: user.id
    cannot :destroy, User, id: user.id
    if user.admin?
      can :manage, [School, Semester, Unit, Subject, NotifyType, User, Feedback, SchoolUser, PointType, Student]
      cannot [:edit, :update, :destroy], User do |user|
        user.admin?
      end
      can [:edit, :update], User, id: user.id
      can [:read, :update], Classroom
    elsif user.manage?
      can :manage, Classroom do |classroom|
        user.list_school.include?(classroom.school_id)
      end
      can [:new, :create, :load_teacher_can_teach], Classroom
      # config new Semester
      can :manage, [Semester]
      can :manage, [Student, StudentClassroom, UserSubject, ClassSubject, StudentSubject, Point, User, SchoolSubject]
      cannot [:edit, :update, :destroy], User do |user|
        user.admin? || user.manage?
      end
    elsif user.teacher?
    elsif user.student_parent?
    end
  end
end
