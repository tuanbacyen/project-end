class NewSemestersController < ApplicationController
  before_action :user_confirmed, :authenticate_user!

  def create
    @classroom = Classroom.new classroom_params
    @classroom.school_id = current_user.first_school.id
    @classroom.sizes = 0
    respond_to do |format|
      notifi = nil
      if @classroom.save
        if true? params[:auto_create]
          subject = ClassroomService.new @classroom
          subject.create
        end
        notifi = {message: "success", type: "1"}
      else
        notifi = {message: "failed", type: "3"}
      end
      format.json{render json: {notifi: notifi}}
    end
  end

  def teacher_can_teach
    list_user = User.load_user_of_school(current_user).load_teacher.user_has_classroom(params[:semester_id]).pluck :name, :birth, :id, :usercode
    list = []
    list_user.map{|u| list << ["#{u[3]} - #{u[0]} - #{u[1].day}/#{u[1].month}/#{u[1].year}", u[2]]}
    respond_to do |format|
      format.json{render json: {list_teacher: list}}
    end
  end

  private
  def classroom_params
    params.require(:classroom).permit :semester_id, :user_id, :name, :number
  end
end
