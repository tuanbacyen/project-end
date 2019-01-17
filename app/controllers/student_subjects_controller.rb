class StudentSubjectsController < ApplicationController
  load_and_authorize_resource

  before_action :get_student, only: [:index, :new, :create, :destroy]
  before_action :get_result, only: :show

  def show; end

  def index
    @student_classrooms = @student.student_classrooms
  end

  def new; end

  def create; end

  def destroy; end

  private

  def get_student
    @student = Student.find_by(id: params[:student_id])
    return if @student
    flash[:danger] = "student not found"
    redirect_to students_path
  end

  def get_result
    @student_subject = StudentSubject.find_by(id: params[:id])
    return if @student_subject
    flash[:danger] = "student subject not found"
    redirect_to students_path
  end
end
