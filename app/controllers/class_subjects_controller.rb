class ClassSubjectsController < ApplicationController
  load_and_authorize_resource except: :create

  before_action :get_classroom, only: [:index, :new, :create, :destroy]
  before_action :get_class_subject, only: :destroy

  def index
    @class_subjects = @classroom.class_subjects
  end

  def new
    @subjects = Subject.load_all_subjects?
  end

  def create
    class_subject = ClassSubjectService.new params
    class_subject.create_cs
    flash[:success] = "done"
    redirect_to classroom_class_subjects_path
  end

  def destroy
    if @class_subject.destroy
      flash[:success] = t "delete success"
    else
      flash[:danger] = t "delete failed"
    end
    redirect_to classroom_class_subjects_path
  end

  private

  def get_classroom
    @classroom = Classroom.find_by(id: params[:classroom_id])
    return if @classroom
    flash[:danger] = "classroom not found"
    redirect_to classrooms_path
  end

  def get_class_subject
    redirect_to classroom_class_subjects_path unless @class_subject = ClassSubject.find_by(id: params[:id])
  end

  def class_subject_params
    params.require(:class_subject).permit(:classroom_id, :classroom_id) if params[:class_subject]
  end
end
