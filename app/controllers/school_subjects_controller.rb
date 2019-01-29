class SchoolSubjectsController < ApplicationController
  load_and_authorize_resource except: [:create, :update, :destroy]

  before_action :user_confirmed, :authenticate_user!
  before_action :load_school_subjects, only: :index
  before_action :get_school_subject, only: [:destroy, :edit]

  def index; end

  def new
    @list_number = current_user.first_school.school_subjects.pluck(:number).uniq
  end

  def edit
    @list_number = SchoolSubject.find_by(id: params[:number]).number
    @school_subject = @school_subject.pluck :subject_id
  end

  def create
    subject = SchoolSubjectService.new params, current_user
    if true? params[:edit]
      subject.update_school_subject
    else
      subject.create_school_subject
    end
    redirect_to school_subjects_path
  end

  def update
    redirect_to school_subjects_path
  end

  def destroy
    if @school_subject.destroy_all
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to school_subjects_path
  end

  private
  def load_school_subjects
    @school_subjects = current_user.first_school.school_subjects
    @list_number = @school_subjects.pluck(:number).uniq
  end

  def get_school_subject
    @school_subject = if params[:number].present?
                        SchoolSubject.where(number: params[:number], school_id: current_user.first_school.id)
                      else
                        SchoolSubject.where(id: params[:id])
                      end
    return if @school_subject.present?
    flash[:danger] = "school subject not found"
    redirect_to school_subjects_path
  end
end
