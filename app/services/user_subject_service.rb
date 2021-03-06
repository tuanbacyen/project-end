class UserSubjectService
  def initialize params, teacher
    @params = params
    @teacher = teacher
  end

  def create_user_subject
    list_params = @params[:subject_ids].map(&:to_i)
    list_sub_has = @teacher.user_subjects.pluck :subject_id
    list_remove = list_sub_has - list_params
    list_add = list_params - list_sub_has
    fail = 0
    list_remove.each do |r_sub_id|
      us = UserSubject.where(user_id: @teacher.id, subject_id: r_sub_id).first
      fail += 1 if us && us&.destroy
    end
    list_add.each do |c_sub_id|
      us = UserSubject.new user_id: @teacher.id, subject_id: c_sub_id
      fail += 1 unless us.save
    end
    fail
  end
end
