class StudentClassroomsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :get_student, only: [:index, :new, :create]
  before_action :get_student_classroom, only: :destroy

  def index
    @student_classrooms = @student.student_classrooms
  end

  def new
    @student_classroom = StudentClassroom.new
  end

  def create
    @student_classroom = @student.student_classrooms.build student_classroom_params
    if @student_classroom.save
      flash[:success] = t "create_success"
      redirect_to student_student_classrooms_path
    else
      render :new
    end
  end

  def destroy
    if @student_classroom.destroy
      flash[:success] = t "delete success"
    else
      flash[:danger] = t "delete failed"
    end
    redirect_to student_student_classrooms_path
  end

  private

  def get_student
    @student = Student.find_by(id: params[:student_id])
    return if @student
    flash[:danger] = "student not found"
    redirect_to students_path
  end

  def get_student_classroom
    redirect_to student_student_classrooms_path unless @student_classroom = StudentClassroom.find_by(id: params[:id])
  end

  def student_classroom_params
    params.require(:student_classroom).permit(:student_id, :classroom_id) if params[:student_classroom]
  end
end
