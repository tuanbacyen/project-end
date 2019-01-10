class UserSubjectsController < ApplicationController
  load_and_authorize_resource except: :create

  before_action :user_confirmed, :authenticate_user!
  before_action :load_user_subjects, only: :index
  before_action :load_user_subject, only: :show
  before_action :get_teacher, only: [:new, :create]
  before_action :get_user_subject, only: [:destroy]

  def index; end

  def new; end

  def create
    subject = UserSubjectService.new params, @teacher
    resutl = subject.create_user_subject
    respond_to do |format|
      format.json{render json: {resutl: resutl}} 
    end
  end

  def destroy
    if @user_subject.destroy
      flash[:success] = "oke"
    else
      flash[:danger] = "Loi"
    end
    redirect_to user_subjects_path
  end

  private
  def load_user_subjects
    @user_subjects = User.load_user_of_school(current_user)
                          .load_teacher
  end

  def get_teacher
    @teacher = User.find_by(id: params[:user_id])
  end

  def load_user_subject
    @user_subject = UserSubject.find_by(id: params[:id])
  end

  def get_user_subject
    @user_subject = UserSubject.find_by(id: params[:id])
    return if @user_subject
    flash[:danger] = "user_subject not found"
    redirect_to user_subjects_path
  end
end
