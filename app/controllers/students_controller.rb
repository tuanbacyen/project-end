class StudentsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_students, only: :index
  before_action :load_student, only: :show
  before_action :new_student, only: :new
  before_action :get_student, only: [:destroy, :update, :edit]

  def show; end

  def index; end

  def new; end

  def create
    if @student.save
      flash[:success] = "create success"
      redirect_to students_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @student.update_attributes student_params
      flash[:success] = t "update_success"
      redirect_to students_path
    else
      render :edit
    end
  end

  def destroy
    if @student.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @student.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to students_path
  end

  private
  def load_all_students
    @students = Student.load_all_students current_user
  end

  def new_student
    @student = Student.new
  end

  def student_params
    params.require(:student).permit :student_code, :name, :birth, :address, :favorite, :phone, :father_name,
      :father_phone, :mother_name, :mother_phone, :user_id, :avatar, :studying
  end

  def load_student
    @student = Student.find_by(id: params[:id])
  end

  def get_student
    @student = Student.find_by(id: params[:id])
    return if @student
    flash[:danger] = "student not found"
    redirect_to students_path
  end
end
