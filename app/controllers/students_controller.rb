class StudentsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_students, only: :index
  before_action :load_student, only: :show
  before_action :new_student, only: :new
  before_action :get_student, only: [:destroy, :update, :edit]
  before_action :get_classroom, only: [:students_classs]

  def show; end

  def index; end

  def new; end

  def create
    @student = current_user.build_student student_params
    if @student.save
      flash[:success] = "create success"
      redirect_to new_student_student_classroom_path @student
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

  def students_classs
    @students = Student.load_student_in_class @classroom.id
  end

  def student_in_school
    list_students = Student.where(school_id: params[:school_id]).student_no_parent.pluck :name, :id, :student_code, :birth
    list = []
    list_students.map{|s| list << ["#{s[2]} - #{s[0]} - #{s[3].day}/#{s[3].month}/#{s[3].year}", s[1]]}
    respond_to do |format|
      format.json{render json: {list_student: list}}
    end
  end

  private
  def load_all_students
    @students = if current_user.admin?
                  Student.load_all_students
                else
                  current_user.manage_get_student.load_all_students
                end
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

  def get_classroom
    @classroom = Classroom.find_by(id: params[:classroom_id])
    return if @classroom
    flash[:danger] = "classroom not found"
    redirect_to classrooms_path
  end
end
