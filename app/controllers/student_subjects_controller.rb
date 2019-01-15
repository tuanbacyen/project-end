class StudentSubjectsController < ApplicationController
  load_and_authorize_resource

  before_action :get_student, only: [:index, :new, :create, :destroy]
  before_action :get_result, only: :show_result

  def show
  end

  def show_result

  end

  def index
    @student_classrooms = @student.student_classrooms
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def get_student
    @student = Student.find_by(id: params[:student_id])
    return if @student
    flash[:danger] = "student not found"
    redirect_to students_path
  end

  def get_result
    @student_subject = StudentSubject.find_by(id: params[:student_subject_id])
    return if @student_class
    flash[:danger] = "student classroom not found"
    redirect_to student_subjects_path
  end
end
