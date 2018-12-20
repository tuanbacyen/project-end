class SubjectsController < ApplicationController
  load_and_authorize_resource

  before_action :user_confirmed, :authenticate_user!
  before_action :load_all_subjects, only: :index
  before_action :new_subject, only: :new
  before_action :get_subject, only: [:destroy, :update, :edit]

  def index; end

  def new; end

  def create
    if @subject.save
      flash[:success] = "create success"
      redirect_to subjects_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "update_success"
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def destroy
    if @subject.check_present?
      flash[:danger] = "mon hoc co gia tri con"
    elsif @subject.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to subjects_path
  end

  def new_auto; end

  def create_auto
    subject = SubjectService.new params
    subject.auto_create_subject
    flash[:success] = "done"
    redirect_to subjects_path
  end

  private
  def load_all_subjects
    @subjects = Subject.load_all_subjects?
  end

  def new_subject
    @subject = Subject.new
  end

  def subject_params
    params.require(:subject).permit :name
  end

  def get_subject
    @subject = Subject.find_by(id: params[:id])
    return if @subject
    flash[:danger] = "subject not found"
    redirect_to subjects_path
  end
end
